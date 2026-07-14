import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mecavoltia_society_app/features/portfolio/data/portfolio_repository_impl.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/portfolio_repository.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';
import 'package:mecavoltia_society_app/features/portfolio/presentation/works_controller.dart';

Work _work(String id, {bool published = false}) => Work(
      id: id,
      slug: 'trabajo-$id',
      categorySlug: 'mecatronica',
      titleEs: 'Trabajo $id',
      titleEn: 'Work $id',
      summaryEs: 'Resumen',
      summaryEn: 'Summary',
      descriptionEs: 'Descripción',
      descriptionEn: 'Description',
      published: published,
      images: const [],
    );

class FakePortfolioRepository implements PortfolioRepository {
  final works = <Work>[_work('1'), _work('2', published: true)];

  @override
  Future<List<Work>> listWorks() async => List.of(works);

  @override
  Future<Work> createWork(WorkDraft draft) async {
    final created = _work('${works.length + 1}');
    works.add(created);
    return created;
  }

  @override
  Future<Work> updateWork(String id, WorkDraft draft) async =>
      works.firstWhere((w) => w.id == id);

  @override
  Future<void> setPublished(String id, {required bool published}) async {
    final index = works.indexWhere((w) => w.id == id);
    works[index] = works[index].copyWith(published: published);
  }

  @override
  Future<void> deleteWork(String id) async {
    works.removeWhere((w) => w.id == id);
  }

  @override
  Future<void> addImage({
    required String workId,
    required Uint8List bytes,
    required String filename,
    required String altEs,
    required String altEn,
    required bool isCover,
  }) async {}

  @override
  Future<void> removeImage({
    required String workId,
    required String imageId,
  }) async {}
}

void main() {
  late FakePortfolioRepository fake;
  late ProviderContainer container;

  setUp(() {
    fake = FakePortfolioRepository();
    container = ProviderContainer(
      overrides: [portfolioRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
  });

  test('lista todos los trabajos, incluidos borradores', () async {
    final works = await container.read(worksControllerProvider.future);

    expect(works, hasLength(2));
    expect(works.where((w) => !w.published), hasLength(1));
  });

  test('togglePublished invierte el estado y recarga', () async {
    await container.read(worksControllerProvider.future);
    final draft = fake.works.first;

    await container
        .read(worksControllerProvider.notifier)
        .togglePublished(draft);

    final works = container.read(worksControllerProvider).value!;
    expect(works.firstWhere((w) => w.id == draft.id).published, isTrue);
  });

  test('delete elimina el trabajo y recarga la lista', () async {
    await container.read(worksControllerProvider.future);
    final target = fake.works.first;

    await container.read(worksControllerProvider.notifier).delete(target);

    final works = container.read(worksControllerProvider).value!;
    expect(works, hasLength(1));
    expect(works.any((w) => w.id == target.id), isFalse);
  });
}
