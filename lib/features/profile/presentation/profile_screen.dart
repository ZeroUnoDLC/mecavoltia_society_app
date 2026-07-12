import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mecavoltia_society_app/core/config/env.dart';
import 'package:mecavoltia_society_app/core/theme/app_theme.dart';
import 'package:mecavoltia_society_app/features/profile/domain/member.dart';
import 'package:mecavoltia_society_app/features/profile/presentation/profile_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: switch (profile) {
        AsyncData(:final value) => _ProfileForm(member: value),
        AsyncError(:final error) => Center(
            child: Text('$error', style: const TextStyle(color: MvColors.error)),
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ProfileForm extends ConsumerStatefulWidget {
  const _ProfileForm({required this.member});

  final Member member;

  @override
  ConsumerState<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullName;
  late final TextEditingController _roleEs;
  late final TextEditingController _roleEn;
  late final TextEditingController _bioEs;
  late final TextEditingController _bioEn;
  late final TextEditingController _linkedin;

  @override
  void initState() {
    super.initState();
    final member = widget.member;
    _fullName = TextEditingController(text: member.fullName);
    _roleEs = TextEditingController(text: member.roleEs);
    _roleEn = TextEditingController(text: member.roleEn);
    _bioEs = TextEditingController(text: member.bioEs);
    _bioEn = TextEditingController(text: member.bioEn);
    _linkedin = TextEditingController(text: member.linkedinUrl ?? '');
  }

  @override
  void dispose() {
    for (final controller in [
      _fullName, _roleEs, _roleEn, _bioEs, _bioEn, _linkedin,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final linkedin = _linkedin.text.trim();
    await ref.read(profileControllerProvider.notifier).save(
          MemberUpdate(
            fullName: _fullName.text.trim(),
            roleEs: _roleEs.text.trim(),
            roleEn: _roleEn.text.trim(),
            bioEs: _bioEs.text.trim(),
            bioEn: _bioEn.text.trim(),
            linkedinUrl: linkedin.isEmpty ? null : linkedin,
          ),
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil guardado')),
      );
    }
  }

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    await ref
        .read(profileControllerProvider.notifier)
        .uploadPhoto(bytes: bytes, filename: picked.name);
  }

  Future<void> _pickCv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    final file = result?.files.firstOrNull;
    final bytes = file?.bytes;
    if (file == null || bytes == null) return;
    await ref
        .read(profileControllerProvider.notifier)
        .uploadCv(bytes: bytes, filename: file.name);
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: MvColors.surface,
                  foregroundImage: member.photoPath != null
                      ? NetworkImage('${Env.apiBaseUrl}${member.photoPath}')
                      : null,
                  child: Text(
                    member.fullName.isNotEmpty ? member.fullName[0] : '?',
                    style: const TextStyle(
                      fontSize: 32,
                      color: MvColors.accent,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _pickPhoto,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Cambiar foto'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _fullName,
            decoration: const InputDecoration(labelText: 'Nombre completo'),
            validator: (value) => (value == null || value.trim().length < 3)
                ? 'Mínimo 3 caracteres'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _roleEs,
            decoration: const InputDecoration(labelText: 'Rol (español)'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _roleEn,
            decoration: const InputDecoration(labelText: 'Role (English)'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _bioEs,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Bio (español)'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _bioEn,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Bio (English)'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _linkedin,
            decoration: const InputDecoration(
              labelText: 'LinkedIn (URL completa)',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text(member.cvPath == null ? 'Sin CV' : 'CV cargado'),
              subtitle: const Text('PDF, máx. 10 MB'),
              trailing: TextButton(
                onPressed: _pickCv,
                child: const Text('Subir CV'),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _save,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Guardar perfil'),
            ),
          ),
        ],
      ),
    );
  }
}
