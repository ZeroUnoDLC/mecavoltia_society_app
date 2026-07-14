// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$publicDioHash() => r'd3944aba3e14c1dd645ffda715b320bdfbf1c671';

/// Cliente SIN auth: login, refresh, logout (no debe llevar Bearer viejo).
///
/// Copied from [publicDio].
@ProviderFor(publicDio)
final publicDioProvider = Provider<Dio>.internal(
  publicDio,
  name: r'publicDioProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$publicDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PublicDioRef = ProviderRef<Dio>;
String _$apiDioHash() => r'b47771fe480d1eae600a2ff2d8617ec4ef1ca016';

/// Cliente autenticado: Bearer automático + refresh single-flight ante 401.
///
/// Copied from [apiDio].
@ProviderFor(apiDio)
final apiDioProvider = Provider<Dio>.internal(
  apiDio,
  name: r'apiDioProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiDioRef = ProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
