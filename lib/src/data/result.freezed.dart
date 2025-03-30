// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Result<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Result<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Result<$T>()';
  }
}

/// @nodoc
class $ResultCopyWith<T, $Res> {
  $ResultCopyWith(Result<T> _, $Res Function(Result<T>) __);
}

/// @nodoc

class ResultOk<T> implements Result<T> {
  const ResultOk(this.value);

  final T value;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResultOkCopyWith<T, ResultOk<T>> get copyWith =>
      _$ResultOkCopyWithImpl<T, ResultOk<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResultOk<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Result<$T>.ok(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ResultOkCopyWith<T, $Res>
    implements $ResultCopyWith<T, $Res> {
  factory $ResultOkCopyWith(
          ResultOk<T> value, $Res Function(ResultOk<T>) _then) =
      _$ResultOkCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$ResultOkCopyWithImpl<T, $Res> implements $ResultOkCopyWith<T, $Res> {
  _$ResultOkCopyWithImpl(this._self, this._then);

  final ResultOk<T> _self;
  final $Res Function(ResultOk<T>) _then;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(ResultOk<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class ResultError<T> implements Result<T> {
  const ResultError(this.e, {this.code, this.stackTrace});

  final dynamic e;
  final String? code;
  final StackTrace? stackTrace;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResultErrorCopyWith<T, ResultError<T>> get copyWith =>
      _$ResultErrorCopyWithImpl<T, ResultError<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResultError<T> &&
            const DeepCollectionEquality().equals(other.e, e) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(e), code, stackTrace);

  @override
  String toString() {
    return 'Result<$T>.error(e: $e, code: $code, stackTrace: $stackTrace)';
  }
}

/// @nodoc
abstract mixin class $ResultErrorCopyWith<T, $Res>
    implements $ResultCopyWith<T, $Res> {
  factory $ResultErrorCopyWith(
          ResultError<T> value, $Res Function(ResultError<T>) _then) =
      _$ResultErrorCopyWithImpl;
  @useResult
  $Res call({dynamic e, String? code, StackTrace? stackTrace});
}

/// @nodoc
class _$ResultErrorCopyWithImpl<T, $Res>
    implements $ResultErrorCopyWith<T, $Res> {
  _$ResultErrorCopyWithImpl(this._self, this._then);

  final ResultError<T> _self;
  final $Res Function(ResultError<T>) _then;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? e = freezed,
    Object? code = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(ResultError<T>(
      freezed == e
          ? _self.e
          : e // ignore: cast_nullable_to_non_nullable
              as dynamic,
      code: freezed == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: freezed == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

// dart format on
