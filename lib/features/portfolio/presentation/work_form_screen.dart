import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mecavoltia_society_app/core/config/env.dart';
import 'package:mecavoltia_society_app/core/errors/failure.dart';
import 'package:mecavoltia_society_app/core/theme/app_theme.dart';
import 'package:mecavoltia_society_app/features/portfolio/data/portfolio_repository_impl.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';
import 'package:mecavoltia_society_app/features/portfolio/presentation/works_controller.dart';

/// Alta y edición de un trabajo, con contenido bilingüe e imágenes.
class WorkFormScreen extends ConsumerStatefulWidget {
  const WorkFormScreen({this.existing, super.key});

  /// null = crear; con valor = editar.
  final Work? existing;

  @override
  ConsumerState<WorkFormScreen> createState() => _WorkFormScreenState();
}

class _WorkFormScreenState extends ConsumerState<WorkFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleEs;
  late final TextEditingController _titleEn;
  late final TextEditingController _summaryEs;
  late final TextEditingController _summaryEn;
  late final TextEditingController _descriptionEs;
  late final TextEditingController _descriptionEn;
  late String _categorySlug;
  late bool _published;
  Work? _work;
  bool _saving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _work = widget.existing;
    final work = _work;
    _titleEs = TextEditingController(text: work?.titleEs);
    _titleEn = TextEditingController(text: work?.titleEn);
    _summaryEs = TextEditingController(text: work?.summaryEs);
    _summaryEn = TextEditingController(text: work?.summaryEn);
    _descriptionEs = TextEditingController(text: work?.descriptionEs);
    _descriptionEn = TextEditingController(text: work?.descriptionEn);
    _categorySlug = work?.categorySlug ?? workCategories.first.slug;
    _published = work?.published ?? false;
  }

  @override
  void dispose() {
    for (final controller in [
      _titleEs, _titleEn, _summaryEs, _summaryEn, _descriptionEs, _descriptionEn,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  WorkDraft _draft() => WorkDraft(
        categorySlug: _categorySlug,
        titleEs: _titleEs.text.trim(),
        titleEn: _titleEn.text.trim(),
        summaryEs: _summaryEs.text.trim(),
        summaryEn: _summaryEn.text.trim(),
        descriptionEs: _descriptionEs.text.trim(),
        descriptionEn: _descriptionEn.text.trim(),
        published: _published,
      );

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _saving = true;
      _errorMessage = null;
    });
    try {
      final repo = ref.read(portfolioRepositoryProvider);
      final current = _work;
      final saved = current == null
          ? await repo.createWork(_draft())
          : await repo.updateWork(current.id, _draft());
      ref.invalidate(worksControllerProvider);
      if (!mounted) return;
      setState(() => _work = saved);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trabajo guardado')),
      );
    } on Failure catch (failure) {
      setState(() => _errorMessage = failure.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _addImage() async {
    final work = _work;
    if (work == null) return;

    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;

    final alt = await _askAltText();
    if (alt == null || !mounted) return;

    setState(() => _saving = true);
    try {
      final bytes = await picked.readAsBytes();
      await ref.read(portfolioRepositoryProvider).addImage(
            workId: work.id,
            bytes: bytes,
            filename: picked.name,
            altEs: alt,
            altEn: alt,
            isCover: work.images.isEmpty,
          );
      await _reloadWork();
    } on Failure catch (failure) {
      setState(() => _errorMessage = failure.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _removeImage(WorkImage image) async {
    final work = _work;
    if (work == null) return;
    setState(() => _saving = true);
    try {
      await ref.read(portfolioRepositoryProvider).removeImage(
            workId: work.id,
            imageId: image.id,
          );
      await _reloadWork();
    } on Failure catch (failure) {
      setState(() => _errorMessage = failure.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _reloadWork() async {
    final works =
        await ref.refresh(worksControllerProvider.future);
    final current = _work;
    if (current != null && mounted) {
      setState(() {
        _work = works.where((w) => w.id == current.id).firstOrNull ?? current;
      });
    }
  }

  Future<String?> _askAltText() {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Texto alternativo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Describe la imagen (SEO y accesibilidad)',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _work != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar trabajo' : 'Nuevo trabajo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              initialValue: _categorySlug,
              decoration: const InputDecoration(labelText: 'Categoría'),
              items: [
                for (final category in workCategories)
                  DropdownMenuItem(
                    value: category.slug,
                    child: Text(category.label),
                  ),
              ],
              onChanged: (value) =>
                  setState(() => _categorySlug = value ?? _categorySlug),
            ),
            const SizedBox(height: 16),
            _bilingualSection('Título', _titleEs, _titleEn, minLength: 3),
            _bilingualSection(
              'Resumen (para las tarjetas y buscadores)',
              _summaryEs,
              _summaryEn,
              minLength: 10,
              maxLines: 2,
            ),
            _bilingualSection(
              'Descripción (problema → solución → resultado)',
              _descriptionEs,
              _descriptionEn,
              minLength: 20,
              maxLines: 6,
            ),
            SwitchListTile(
              title: const Text('Publicado'),
              subtitle: const Text('Visible en la web pública'),
              value: _published,
              onChanged: (value) => setState(() => _published = value),
            ),
            const SizedBox(height: 8),
            if (isEditing) _imagesSection() else const _SaveFirstHint(),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: const TextStyle(color: MvColors.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(_saving ? 'Guardando…' : 'Guardar'),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bilingualSection(
    String label,
    TextEditingController es,
    TextEditingController en, {
    required int minLength,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextFormField(
            controller: es,
            maxLines: maxLines,
            decoration: const InputDecoration(labelText: 'Español'),
            validator: (value) => (value == null || value.trim().length < minLength)
                ? 'Mínimo $minLength caracteres'
                : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: en,
            maxLines: maxLines,
            decoration: const InputDecoration(
              labelText: 'English (si queda vacío, la web muestra el español)',
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagesSection() {
    final work = _work!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Imágenes',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            TextButton.icon(
              onPressed: _saving ? null : _addImage,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Agregar'),
            ),
          ],
        ),
        if (work.images.isEmpty)
          const Text(
            'Sin imágenes todavía. La primera que subas queda como portada.',
            style: TextStyle(color: MvColors.muted),
          )
        else
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              for (final image in work.images)
                Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${Env.apiBaseUrl}${image.path}',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const ColoredBox(color: MvColors.surface),
                      ),
                    ),
                    if (image.isCover)
                      const Positioned(
                        left: 4,
                        top: 4,
                        child: Chip(
                          label: Text('Portada'),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        style: IconButton.styleFrom(
                          backgroundColor: MvColors.bg,
                        ),
                        onPressed:
                            _saving ? null : () => _removeImage(image),
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

class _SaveFirstHint extends StatelessWidget {
  const _SaveFirstHint();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'Guardá el trabajo primero y después vas a poder subirle imágenes.',
          style: TextStyle(color: MvColors.muted),
        ),
      ),
    );
  }
}
