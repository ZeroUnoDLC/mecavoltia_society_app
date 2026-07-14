// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkImage {
  String get id => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get altEs => throw _privateConstructorUsedError;
  String get altEn => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  bool get isCover => throw _privateConstructorUsedError;

  /// Create a copy of WorkImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkImageCopyWith<WorkImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkImageCopyWith<$Res> {
  factory $WorkImageCopyWith(WorkImage value, $Res Function(WorkImage) then) =
      _$WorkImageCopyWithImpl<$Res, WorkImage>;
  @useResult
  $Res call({
    String id,
    String path,
    String altEs,
    String altEn,
    int position,
    bool isCover,
  });
}

/// @nodoc
class _$WorkImageCopyWithImpl<$Res, $Val extends WorkImage>
    implements $WorkImageCopyWith<$Res> {
  _$WorkImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? altEs = null,
    Object? altEn = null,
    Object? position = null,
    Object? isCover = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            path: null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String,
            altEs: null == altEs
                ? _value.altEs
                : altEs // ignore: cast_nullable_to_non_nullable
                      as String,
            altEn: null == altEn
                ? _value.altEn
                : altEn // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            isCover: null == isCover
                ? _value.isCover
                : isCover // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkImageImplCopyWith<$Res>
    implements $WorkImageCopyWith<$Res> {
  factory _$$WorkImageImplCopyWith(
    _$WorkImageImpl value,
    $Res Function(_$WorkImageImpl) then,
  ) = __$$WorkImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String path,
    String altEs,
    String altEn,
    int position,
    bool isCover,
  });
}

/// @nodoc
class __$$WorkImageImplCopyWithImpl<$Res>
    extends _$WorkImageCopyWithImpl<$Res, _$WorkImageImpl>
    implements _$$WorkImageImplCopyWith<$Res> {
  __$$WorkImageImplCopyWithImpl(
    _$WorkImageImpl _value,
    $Res Function(_$WorkImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? altEs = null,
    Object? altEn = null,
    Object? position = null,
    Object? isCover = null,
  }) {
    return _then(
      _$WorkImageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        altEs: null == altEs
            ? _value.altEs
            : altEs // ignore: cast_nullable_to_non_nullable
                  as String,
        altEn: null == altEn
            ? _value.altEn
            : altEn // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        isCover: null == isCover
            ? _value.isCover
            : isCover // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WorkImageImpl implements _WorkImage {
  const _$WorkImageImpl({
    required this.id,
    required this.path,
    required this.altEs,
    required this.altEn,
    required this.position,
    required this.isCover,
  });

  @override
  final String id;
  @override
  final String path;
  @override
  final String altEs;
  @override
  final String altEn;
  @override
  final int position;
  @override
  final bool isCover;

  @override
  String toString() {
    return 'WorkImage(id: $id, path: $path, altEs: $altEs, altEn: $altEn, position: $position, isCover: $isCover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.altEs, altEs) || other.altEs == altEs) &&
            (identical(other.altEn, altEn) || other.altEn == altEn) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isCover, isCover) || other.isCover == isCover));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, path, altEs, altEn, position, isCover);

  /// Create a copy of WorkImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkImageImplCopyWith<_$WorkImageImpl> get copyWith =>
      __$$WorkImageImplCopyWithImpl<_$WorkImageImpl>(this, _$identity);
}

abstract class _WorkImage implements WorkImage {
  const factory _WorkImage({
    required final String id,
    required final String path,
    required final String altEs,
    required final String altEn,
    required final int position,
    required final bool isCover,
  }) = _$WorkImageImpl;

  @override
  String get id;
  @override
  String get path;
  @override
  String get altEs;
  @override
  String get altEn;
  @override
  int get position;
  @override
  bool get isCover;

  /// Create a copy of WorkImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkImageImplCopyWith<_$WorkImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Work {
  String get id => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get categorySlug => throw _privateConstructorUsedError;
  String get titleEs => throw _privateConstructorUsedError;
  String get titleEn => throw _privateConstructorUsedError;
  String get summaryEs => throw _privateConstructorUsedError;
  String get summaryEn => throw _privateConstructorUsedError;
  String get descriptionEs => throw _privateConstructorUsedError;
  String get descriptionEn => throw _privateConstructorUsedError;
  bool get published => throw _privateConstructorUsedError;
  List<WorkImage> get images => throw _privateConstructorUsedError;

  /// Create a copy of Work
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkCopyWith<Work> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkCopyWith<$Res> {
  factory $WorkCopyWith(Work value, $Res Function(Work) then) =
      _$WorkCopyWithImpl<$Res, Work>;
  @useResult
  $Res call({
    String id,
    String slug,
    String categorySlug,
    String titleEs,
    String titleEn,
    String summaryEs,
    String summaryEn,
    String descriptionEs,
    String descriptionEn,
    bool published,
    List<WorkImage> images,
  });
}

/// @nodoc
class _$WorkCopyWithImpl<$Res, $Val extends Work>
    implements $WorkCopyWith<$Res> {
  _$WorkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Work
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? categorySlug = null,
    Object? titleEs = null,
    Object? titleEn = null,
    Object? summaryEs = null,
    Object? summaryEn = null,
    Object? descriptionEs = null,
    Object? descriptionEn = null,
    Object? published = null,
    Object? images = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            categorySlug: null == categorySlug
                ? _value.categorySlug
                : categorySlug // ignore: cast_nullable_to_non_nullable
                      as String,
            titleEs: null == titleEs
                ? _value.titleEs
                : titleEs // ignore: cast_nullable_to_non_nullable
                      as String,
            titleEn: null == titleEn
                ? _value.titleEn
                : titleEn // ignore: cast_nullable_to_non_nullable
                      as String,
            summaryEs: null == summaryEs
                ? _value.summaryEs
                : summaryEs // ignore: cast_nullable_to_non_nullable
                      as String,
            summaryEn: null == summaryEn
                ? _value.summaryEn
                : summaryEn // ignore: cast_nullable_to_non_nullable
                      as String,
            descriptionEs: null == descriptionEs
                ? _value.descriptionEs
                : descriptionEs // ignore: cast_nullable_to_non_nullable
                      as String,
            descriptionEn: null == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String,
            published: null == published
                ? _value.published
                : published // ignore: cast_nullable_to_non_nullable
                      as bool,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<WorkImage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkImplCopyWith<$Res> implements $WorkCopyWith<$Res> {
  factory _$$WorkImplCopyWith(
    _$WorkImpl value,
    $Res Function(_$WorkImpl) then,
  ) = __$$WorkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String slug,
    String categorySlug,
    String titleEs,
    String titleEn,
    String summaryEs,
    String summaryEn,
    String descriptionEs,
    String descriptionEn,
    bool published,
    List<WorkImage> images,
  });
}

/// @nodoc
class __$$WorkImplCopyWithImpl<$Res>
    extends _$WorkCopyWithImpl<$Res, _$WorkImpl>
    implements _$$WorkImplCopyWith<$Res> {
  __$$WorkImplCopyWithImpl(_$WorkImpl _value, $Res Function(_$WorkImpl) _then)
    : super(_value, _then);

  /// Create a copy of Work
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? categorySlug = null,
    Object? titleEs = null,
    Object? titleEn = null,
    Object? summaryEs = null,
    Object? summaryEn = null,
    Object? descriptionEs = null,
    Object? descriptionEn = null,
    Object? published = null,
    Object? images = null,
  }) {
    return _then(
      _$WorkImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        categorySlug: null == categorySlug
            ? _value.categorySlug
            : categorySlug // ignore: cast_nullable_to_non_nullable
                  as String,
        titleEs: null == titleEs
            ? _value.titleEs
            : titleEs // ignore: cast_nullable_to_non_nullable
                  as String,
        titleEn: null == titleEn
            ? _value.titleEn
            : titleEn // ignore: cast_nullable_to_non_nullable
                  as String,
        summaryEs: null == summaryEs
            ? _value.summaryEs
            : summaryEs // ignore: cast_nullable_to_non_nullable
                  as String,
        summaryEn: null == summaryEn
            ? _value.summaryEn
            : summaryEn // ignore: cast_nullable_to_non_nullable
                  as String,
        descriptionEs: null == descriptionEs
            ? _value.descriptionEs
            : descriptionEs // ignore: cast_nullable_to_non_nullable
                  as String,
        descriptionEn: null == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String,
        published: null == published
            ? _value.published
            : published // ignore: cast_nullable_to_non_nullable
                  as bool,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<WorkImage>,
      ),
    );
  }
}

/// @nodoc

class _$WorkImpl implements _Work {
  const _$WorkImpl({
    required this.id,
    required this.slug,
    required this.categorySlug,
    required this.titleEs,
    required this.titleEn,
    required this.summaryEs,
    required this.summaryEn,
    required this.descriptionEs,
    required this.descriptionEn,
    required this.published,
    required final List<WorkImage> images,
  }) : _images = images;

  @override
  final String id;
  @override
  final String slug;
  @override
  final String categorySlug;
  @override
  final String titleEs;
  @override
  final String titleEn;
  @override
  final String summaryEs;
  @override
  final String summaryEn;
  @override
  final String descriptionEs;
  @override
  final String descriptionEn;
  @override
  final bool published;
  final List<WorkImage> _images;
  @override
  List<WorkImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'Work(id: $id, slug: $slug, categorySlug: $categorySlug, titleEs: $titleEs, titleEn: $titleEn, summaryEs: $summaryEs, summaryEn: $summaryEn, descriptionEs: $descriptionEs, descriptionEn: $descriptionEn, published: $published, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.categorySlug, categorySlug) ||
                other.categorySlug == categorySlug) &&
            (identical(other.titleEs, titleEs) || other.titleEs == titleEs) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            (identical(other.summaryEs, summaryEs) ||
                other.summaryEs == summaryEs) &&
            (identical(other.summaryEn, summaryEn) ||
                other.summaryEn == summaryEn) &&
            (identical(other.descriptionEs, descriptionEs) ||
                other.descriptionEs == descriptionEs) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.published, published) ||
                other.published == published) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    slug,
    categorySlug,
    titleEs,
    titleEn,
    summaryEs,
    summaryEn,
    descriptionEs,
    descriptionEn,
    published,
    const DeepCollectionEquality().hash(_images),
  );

  /// Create a copy of Work
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkImplCopyWith<_$WorkImpl> get copyWith =>
      __$$WorkImplCopyWithImpl<_$WorkImpl>(this, _$identity);
}

abstract class _Work implements Work {
  const factory _Work({
    required final String id,
    required final String slug,
    required final String categorySlug,
    required final String titleEs,
    required final String titleEn,
    required final String summaryEs,
    required final String summaryEn,
    required final String descriptionEs,
    required final String descriptionEn,
    required final bool published,
    required final List<WorkImage> images,
  }) = _$WorkImpl;

  @override
  String get id;
  @override
  String get slug;
  @override
  String get categorySlug;
  @override
  String get titleEs;
  @override
  String get titleEn;
  @override
  String get summaryEs;
  @override
  String get summaryEn;
  @override
  String get descriptionEs;
  @override
  String get descriptionEn;
  @override
  bool get published;
  @override
  List<WorkImage> get images;

  /// Create a copy of Work
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkImplCopyWith<_$WorkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkDraft {
  String get categorySlug => throw _privateConstructorUsedError;
  String get titleEs => throw _privateConstructorUsedError;
  String get titleEn => throw _privateConstructorUsedError;
  String get summaryEs => throw _privateConstructorUsedError;
  String get summaryEn => throw _privateConstructorUsedError;
  String get descriptionEs => throw _privateConstructorUsedError;
  String get descriptionEn => throw _privateConstructorUsedError;
  bool get published => throw _privateConstructorUsedError;

  /// Create a copy of WorkDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkDraftCopyWith<WorkDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkDraftCopyWith<$Res> {
  factory $WorkDraftCopyWith(WorkDraft value, $Res Function(WorkDraft) then) =
      _$WorkDraftCopyWithImpl<$Res, WorkDraft>;
  @useResult
  $Res call({
    String categorySlug,
    String titleEs,
    String titleEn,
    String summaryEs,
    String summaryEn,
    String descriptionEs,
    String descriptionEn,
    bool published,
  });
}

/// @nodoc
class _$WorkDraftCopyWithImpl<$Res, $Val extends WorkDraft>
    implements $WorkDraftCopyWith<$Res> {
  _$WorkDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categorySlug = null,
    Object? titleEs = null,
    Object? titleEn = null,
    Object? summaryEs = null,
    Object? summaryEn = null,
    Object? descriptionEs = null,
    Object? descriptionEn = null,
    Object? published = null,
  }) {
    return _then(
      _value.copyWith(
            categorySlug: null == categorySlug
                ? _value.categorySlug
                : categorySlug // ignore: cast_nullable_to_non_nullable
                      as String,
            titleEs: null == titleEs
                ? _value.titleEs
                : titleEs // ignore: cast_nullable_to_non_nullable
                      as String,
            titleEn: null == titleEn
                ? _value.titleEn
                : titleEn // ignore: cast_nullable_to_non_nullable
                      as String,
            summaryEs: null == summaryEs
                ? _value.summaryEs
                : summaryEs // ignore: cast_nullable_to_non_nullable
                      as String,
            summaryEn: null == summaryEn
                ? _value.summaryEn
                : summaryEn // ignore: cast_nullable_to_non_nullable
                      as String,
            descriptionEs: null == descriptionEs
                ? _value.descriptionEs
                : descriptionEs // ignore: cast_nullable_to_non_nullable
                      as String,
            descriptionEn: null == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String,
            published: null == published
                ? _value.published
                : published // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkDraftImplCopyWith<$Res>
    implements $WorkDraftCopyWith<$Res> {
  factory _$$WorkDraftImplCopyWith(
    _$WorkDraftImpl value,
    $Res Function(_$WorkDraftImpl) then,
  ) = __$$WorkDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String categorySlug,
    String titleEs,
    String titleEn,
    String summaryEs,
    String summaryEn,
    String descriptionEs,
    String descriptionEn,
    bool published,
  });
}

/// @nodoc
class __$$WorkDraftImplCopyWithImpl<$Res>
    extends _$WorkDraftCopyWithImpl<$Res, _$WorkDraftImpl>
    implements _$$WorkDraftImplCopyWith<$Res> {
  __$$WorkDraftImplCopyWithImpl(
    _$WorkDraftImpl _value,
    $Res Function(_$WorkDraftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categorySlug = null,
    Object? titleEs = null,
    Object? titleEn = null,
    Object? summaryEs = null,
    Object? summaryEn = null,
    Object? descriptionEs = null,
    Object? descriptionEn = null,
    Object? published = null,
  }) {
    return _then(
      _$WorkDraftImpl(
        categorySlug: null == categorySlug
            ? _value.categorySlug
            : categorySlug // ignore: cast_nullable_to_non_nullable
                  as String,
        titleEs: null == titleEs
            ? _value.titleEs
            : titleEs // ignore: cast_nullable_to_non_nullable
                  as String,
        titleEn: null == titleEn
            ? _value.titleEn
            : titleEn // ignore: cast_nullable_to_non_nullable
                  as String,
        summaryEs: null == summaryEs
            ? _value.summaryEs
            : summaryEs // ignore: cast_nullable_to_non_nullable
                  as String,
        summaryEn: null == summaryEn
            ? _value.summaryEn
            : summaryEn // ignore: cast_nullable_to_non_nullable
                  as String,
        descriptionEs: null == descriptionEs
            ? _value.descriptionEs
            : descriptionEs // ignore: cast_nullable_to_non_nullable
                  as String,
        descriptionEn: null == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String,
        published: null == published
            ? _value.published
            : published // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WorkDraftImpl implements _WorkDraft {
  const _$WorkDraftImpl({
    required this.categorySlug,
    required this.titleEs,
    required this.titleEn,
    required this.summaryEs,
    required this.summaryEn,
    required this.descriptionEs,
    required this.descriptionEn,
    required this.published,
  });

  @override
  final String categorySlug;
  @override
  final String titleEs;
  @override
  final String titleEn;
  @override
  final String summaryEs;
  @override
  final String summaryEn;
  @override
  final String descriptionEs;
  @override
  final String descriptionEn;
  @override
  final bool published;

  @override
  String toString() {
    return 'WorkDraft(categorySlug: $categorySlug, titleEs: $titleEs, titleEn: $titleEn, summaryEs: $summaryEs, summaryEn: $summaryEn, descriptionEs: $descriptionEs, descriptionEn: $descriptionEn, published: $published)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkDraftImpl &&
            (identical(other.categorySlug, categorySlug) ||
                other.categorySlug == categorySlug) &&
            (identical(other.titleEs, titleEs) || other.titleEs == titleEs) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            (identical(other.summaryEs, summaryEs) ||
                other.summaryEs == summaryEs) &&
            (identical(other.summaryEn, summaryEn) ||
                other.summaryEn == summaryEn) &&
            (identical(other.descriptionEs, descriptionEs) ||
                other.descriptionEs == descriptionEs) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.published, published) ||
                other.published == published));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    categorySlug,
    titleEs,
    titleEn,
    summaryEs,
    summaryEn,
    descriptionEs,
    descriptionEn,
    published,
  );

  /// Create a copy of WorkDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkDraftImplCopyWith<_$WorkDraftImpl> get copyWith =>
      __$$WorkDraftImplCopyWithImpl<_$WorkDraftImpl>(this, _$identity);
}

abstract class _WorkDraft implements WorkDraft {
  const factory _WorkDraft({
    required final String categorySlug,
    required final String titleEs,
    required final String titleEn,
    required final String summaryEs,
    required final String summaryEn,
    required final String descriptionEs,
    required final String descriptionEn,
    required final bool published,
  }) = _$WorkDraftImpl;

  @override
  String get categorySlug;
  @override
  String get titleEs;
  @override
  String get titleEn;
  @override
  String get summaryEs;
  @override
  String get summaryEn;
  @override
  String get descriptionEs;
  @override
  String get descriptionEn;
  @override
  bool get published;

  /// Create a copy of WorkDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkDraftImplCopyWith<_$WorkDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
