// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SessionUser {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;

  /// Create a copy of SessionUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionUserCopyWith<SessionUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUserCopyWith<$Res> {
  factory $SessionUserCopyWith(
    SessionUser value,
    $Res Function(SessionUser) then,
  ) = _$SessionUserCopyWithImpl<$Res, SessionUser>;
  @useResult
  $Res call({String id, String email, String displayName});
}

/// @nodoc
class _$SessionUserCopyWithImpl<$Res, $Val extends SessionUser>
    implements $SessionUserCopyWith<$Res> {
  _$SessionUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionUserImplCopyWith<$Res>
    implements $SessionUserCopyWith<$Res> {
  factory _$$SessionUserImplCopyWith(
    _$SessionUserImpl value,
    $Res Function(_$SessionUserImpl) then,
  ) = __$$SessionUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String email, String displayName});
}

/// @nodoc
class __$$SessionUserImplCopyWithImpl<$Res>
    extends _$SessionUserCopyWithImpl<$Res, _$SessionUserImpl>
    implements _$$SessionUserImplCopyWith<$Res> {
  __$$SessionUserImplCopyWithImpl(
    _$SessionUserImpl _value,
    $Res Function(_$SessionUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
  }) {
    return _then(
      _$SessionUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SessionUserImpl implements _SessionUser {
  const _$SessionUserImpl({
    required this.id,
    required this.email,
    required this.displayName,
  });

  @override
  final String id;
  @override
  final String email;
  @override
  final String displayName;

  @override
  String toString() {
    return 'SessionUser(id: $id, email: $email, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, email, displayName);

  /// Create a copy of SessionUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionUserImplCopyWith<_$SessionUserImpl> get copyWith =>
      __$$SessionUserImplCopyWithImpl<_$SessionUserImpl>(this, _$identity);
}

abstract class _SessionUser implements SessionUser {
  const factory _SessionUser({
    required final String id,
    required final String email,
    required final String displayName,
  }) = _$SessionUserImpl;

  @override
  String get id;
  @override
  String get email;
  @override
  String get displayName;

  /// Create a copy of SessionUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionUserImplCopyWith<_$SessionUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
