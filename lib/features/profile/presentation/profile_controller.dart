import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mecavoltia_society_app/features/profile/data/profile_repository_impl.dart';
import 'package:mecavoltia_society_app/features/profile/domain/member.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<Member> build() => ref.watch(profileRepositoryProvider).getMe();

  Future<void> save(MemberUpdate update) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(profileRepositoryProvider).updateMe(update),
    );
  }

  Future<void> uploadPhoto({
    required Uint8List bytes,
    required String filename,
  }) async {
    state = await AsyncValue.guard(
      () => ref
          .read(profileRepositoryProvider)
          .uploadPhoto(bytes: bytes, filename: filename),
    );
  }

  Future<void> uploadCv({
    required Uint8List bytes,
    required String filename,
  }) async {
    state = await AsyncValue.guard(
      () => ref
          .read(profileRepositoryProvider)
          .uploadCv(bytes: bytes, filename: filename),
    );
  }
}
