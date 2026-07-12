import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mecavoltia_society_app/core/theme/app_theme.dart';
import 'package:mecavoltia_society_app/features/auth/presentation/auth_controller.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';
import 'package:mecavoltia_society_app/features/portfolio/presentation/works_controller.dart';

class WorksScreen extends ConsumerWidget {
  const WorksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final works = ref.watch(worksControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portafolio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Mi perfil',
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/works/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo trabajo'),
      ),
      body: switch (works) {
        AsyncData(:final value) when value.isEmpty => const _EmptyState(),
        AsyncData(:final value) => RefreshIndicator(
            onRefresh: () => ref.refresh(worksControllerProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: value.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  _WorkCard(work: value[index]),
            ),
          ),
        AsyncError(:final error) => _ErrorState(error: error),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _WorkCard extends ConsumerWidget {
  const _WorkCard({required this.work});

  final Work work;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = workCategories
        .where((c) => c.slug == work.categorySlug)
        .map((c) => c.label)
        .firstOrNull;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: () => context.push('/works/${work.id}/edit', extra: work),
        title: Text(
          work.titleEs,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Chip(
                label: Text(category ?? work.categorySlug),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                label: Text(work.published ? 'Publicado' : 'Borrador'),
                visualDensity: VisualDensity.compact,
                backgroundColor: work.published
                    ? MvColors.accent
                    : MvColors.surface,
                labelStyle: TextStyle(
                  color:
                      work.published ? MvColors.accentInk : MvColors.muted,
                ),
              ),
              Chip(
                label: Text('${work.images.length} fotos'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (action) async {
            final controller = ref.read(worksControllerProvider.notifier);
            if (action == 'publish') await controller.togglePublished(work);
            if (action == 'delete' && context.mounted) {
              final confirmed = await _confirmDelete(context, work);
              if (confirmed) await controller.delete(work);
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 'publish',
              child: Text(work.published ? 'Despublicar' : 'Publicar'),
            ),
            const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, Work work) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar trabajo?'),
        content: Text(
          '"${work.titleEs}" y sus imágenes se eliminan de forma permanente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'Todavía no hay trabajos.\n¡Creá el primero con el botón de abajo!',
          textAlign: TextAlign.center,
          style: TextStyle(color: MvColors.muted, fontSize: 16),
        ),
      ),
    );
  }
}

class _ErrorState extends ConsumerWidget {
  const _ErrorState({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$error', style: const TextStyle(color: MvColors.error)),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => ref.invalidate(worksControllerProvider),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
