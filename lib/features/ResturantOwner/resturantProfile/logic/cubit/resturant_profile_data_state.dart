import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'resturant_profile_data_state.freezed.dart';

@freezed
class ResturantProfileDataState<T> with _$ResturantProfileDataState {
  const factory ResturantProfileDataState.initial() = _Initial;
  const factory ResturantProfileDataState.loading() = Loading;
  const factory ResturantProfileDataState.success(T data) = Success;
  const factory ResturantProfileDataState.fail(ApiErrorModel error) = Fail;
  const factory ResturantProfileDataState.loadingUpdate() = LoadingUpdate;
  const factory ResturantProfileDataState.successUpdate(T data) = SuccessUpdate;
  const factory ResturantProfileDataState.failUpdate(ApiErrorModel error) = FailUpdate;
}
