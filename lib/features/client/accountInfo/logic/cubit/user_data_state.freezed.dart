// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserDataState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataStateCopyWith<T, $Res> {
  factory $UserDataStateCopyWith(
          UserDataState<T> value, $Res Function(UserDataState<T>) then) =
      _$UserDataStateCopyWithImpl<T, $Res, UserDataState<T>>;
}

/// @nodoc
class _$UserDataStateCopyWithImpl<T, $Res, $Val extends UserDataState<T>>
    implements $UserDataStateCopyWith<T, $Res> {
  _$UserDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl<T> implements _Initial<T> {
  const _$InitialImpl();

  @override
  String toString() {
    return 'UserDataState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial<T> implements UserDataState<T> {
  const factory _Initial() = _$InitialImpl<T>;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl<T> implements Loading<T> {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'UserDataState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<T> implements UserDataState<T> {
  const factory Loading() = _$LoadingImpl<T>;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<T, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<T> value, $Res Function(_$SuccessImpl<T>) then) =
      __$$SuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$SuccessImpl<T>>
    implements _$$SuccessImplCopyWith<T, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<T> _value, $Res Function(_$SuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<T> implements Success<T> {
  const _$SuccessImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'UserDataState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      __$$SuccessImplCopyWithImpl<T, _$SuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T> implements UserDataState<T> {
  const factory Success(final T data) = _$SuccessImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailImplCopyWith<T, $Res> {
  factory _$$FailImplCopyWith(
          _$FailImpl<T> value, $Res Function(_$FailImpl<T>) then) =
      __$$FailImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({ApiErrorModel error});
}

/// @nodoc
class __$$FailImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$FailImpl<T>>
    implements _$$FailImplCopyWith<T, $Res> {
  __$$FailImplCopyWithImpl(
      _$FailImpl<T> _value, $Res Function(_$FailImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FailImpl<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$FailImpl<T> implements Fail<T> {
  const _$FailImpl(this.error);

  @override
  final ApiErrorModel error;

  @override
  String toString() {
    return 'UserDataState<$T>.fail(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailImplCopyWith<T, _$FailImpl<T>> get copyWith =>
      __$$FailImplCopyWithImpl<T, _$FailImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return fail(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return fail?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return fail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return fail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(this);
    }
    return orElse();
  }
}

abstract class Fail<T> implements UserDataState<T> {
  const factory Fail(final ApiErrorModel error) = _$FailImpl<T>;

  ApiErrorModel get error;
  @JsonKey(ignore: true)
  _$$FailImplCopyWith<T, _$FailImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateLoadingImplCopyWith<T, $Res> {
  factory _$$UpdateLoadingImplCopyWith(_$UpdateLoadingImpl<T> value,
          $Res Function(_$UpdateLoadingImpl<T>) then) =
      __$$UpdateLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UpdateLoadingImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$UpdateLoadingImpl<T>>
    implements _$$UpdateLoadingImplCopyWith<T, $Res> {
  __$$UpdateLoadingImplCopyWithImpl(_$UpdateLoadingImpl<T> _value,
      $Res Function(_$UpdateLoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UpdateLoadingImpl<T> implements UpdateLoading<T> {
  const _$UpdateLoadingImpl();

  @override
  String toString() {
    return 'UserDataState<$T>.updateLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return updateLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return updateLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (updateLoading != null) {
      return updateLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return updateLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return updateLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (updateLoading != null) {
      return updateLoading(this);
    }
    return orElse();
  }
}

abstract class UpdateLoading<T> implements UserDataState<T> {
  const factory UpdateLoading() = _$UpdateLoadingImpl<T>;
}

/// @nodoc
abstract class _$$UpdateSuccessImplCopyWith<T, $Res> {
  factory _$$UpdateSuccessImplCopyWith(_$UpdateSuccessImpl<T> value,
          $Res Function(_$UpdateSuccessImpl<T>) then) =
      __$$UpdateSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$UpdateSuccessImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$UpdateSuccessImpl<T>>
    implements _$$UpdateSuccessImplCopyWith<T, $Res> {
  __$$UpdateSuccessImplCopyWithImpl(_$UpdateSuccessImpl<T> _value,
      $Res Function(_$UpdateSuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$UpdateSuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$UpdateSuccessImpl<T> implements UpdateSuccess<T> {
  const _$UpdateSuccessImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'UserDataState<$T>.updateSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSuccessImplCopyWith<T, _$UpdateSuccessImpl<T>> get copyWith =>
      __$$UpdateSuccessImplCopyWithImpl<T, _$UpdateSuccessImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return updateSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return updateSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (updateSuccess != null) {
      return updateSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return updateSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return updateSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (updateSuccess != null) {
      return updateSuccess(this);
    }
    return orElse();
  }
}

abstract class UpdateSuccess<T> implements UserDataState<T> {
  const factory UpdateSuccess(final T data) = _$UpdateSuccessImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$UpdateSuccessImplCopyWith<T, _$UpdateSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateFailImplCopyWith<T, $Res> {
  factory _$$UpdateFailImplCopyWith(
          _$UpdateFailImpl<T> value, $Res Function(_$UpdateFailImpl<T>) then) =
      __$$UpdateFailImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({ApiErrorModel error});
}

/// @nodoc
class __$$UpdateFailImplCopyWithImpl<T, $Res>
    extends _$UserDataStateCopyWithImpl<T, $Res, _$UpdateFailImpl<T>>
    implements _$$UpdateFailImplCopyWith<T, $Res> {
  __$$UpdateFailImplCopyWithImpl(
      _$UpdateFailImpl<T> _value, $Res Function(_$UpdateFailImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$UpdateFailImpl<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$UpdateFailImpl<T> implements UpdateFail<T> {
  const _$UpdateFailImpl(this.error);

  @override
  final ApiErrorModel error;

  @override
  String toString() {
    return 'UserDataState<$T>.updateFail(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateFailImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateFailImplCopyWith<T, _$UpdateFailImpl<T>> get copyWith =>
      __$$UpdateFailImplCopyWithImpl<T, _$UpdateFailImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(T data) success,
    required TResult Function(ApiErrorModel error) fail,
    required TResult Function() updateLoading,
    required TResult Function(T data) updateSuccess,
    required TResult Function(ApiErrorModel error) updateFail,
  }) {
    return updateFail(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(T data)? success,
    TResult? Function(ApiErrorModel error)? fail,
    TResult? Function()? updateLoading,
    TResult? Function(T data)? updateSuccess,
    TResult? Function(ApiErrorModel error)? updateFail,
  }) {
    return updateFail?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(T data)? success,
    TResult Function(ApiErrorModel error)? fail,
    TResult Function()? updateLoading,
    TResult Function(T data)? updateSuccess,
    TResult Function(ApiErrorModel error)? updateFail,
    required TResult orElse(),
  }) {
    if (updateFail != null) {
      return updateFail(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Fail<T> value) fail,
    required TResult Function(UpdateLoading<T> value) updateLoading,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateFail<T> value) updateFail,
  }) {
    return updateFail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Fail<T> value)? fail,
    TResult? Function(UpdateLoading<T> value)? updateLoading,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateFail<T> value)? updateFail,
  }) {
    return updateFail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Fail<T> value)? fail,
    TResult Function(UpdateLoading<T> value)? updateLoading,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateFail<T> value)? updateFail,
    required TResult orElse(),
  }) {
    if (updateFail != null) {
      return updateFail(this);
    }
    return orElse();
  }
}

abstract class UpdateFail<T> implements UserDataState<T> {
  const factory UpdateFail(final ApiErrorModel error) = _$UpdateFailImpl<T>;

  ApiErrorModel get error;
  @JsonKey(ignore: true)
  _$$UpdateFailImplCopyWith<T, _$UpdateFailImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
