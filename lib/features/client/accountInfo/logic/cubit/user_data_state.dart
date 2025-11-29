import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'user_data_state.freezed.dart';

@freezed
class UserDataState<T> with _$UserDataState {
  const factory UserDataState.initial() = _Initial;
  const factory UserDataState.loading() = Loading;
  const factory UserDataState.success(T data) = Success<T>;
  const factory UserDataState.fail(ApiErrorModel error) = Fail;
  const factory UserDataState.updateLoading() = UpdateLoading;
  const factory UserDataState.updateSuccess(T data) = UpdateSuccess<T>;
  const factory UserDataState.updateFail(ApiErrorModel error) = UpdateFail;
}
