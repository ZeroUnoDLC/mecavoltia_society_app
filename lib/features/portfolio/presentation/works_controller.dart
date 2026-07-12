import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mecavoltia_society_app/features/portfolio/data/portfolio_repository_impl.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';

part 'works_controller.g.dart';

@riverpod
class WorksController extends _$WorksController {
  @override
  Future<List<Work>> build() =>
      ref.watch(portfolioRepositoryProvider).listWorks();

  Future<void> togglePublished(Work work) async {
    final repo = ref.read(portfolioRepositoryProvider);
    await repo.setPublished(work.id, published: !work.published);
    ref.invalidateSelf();
    await future;
  }

  Future<void> delete(Work work) async {
    await ref.read(portfolioRepositoryProvider).deleteWork(work.id);
    ref.invalidateSelf();
    await future;
  }
}
