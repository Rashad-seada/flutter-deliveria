import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'resturant_data_state.freezed.dart';

@freezed
class ResturantDataState<T> with _$ResturantDataState {
  const factory ResturantDataState.initial() = _Initial;
  const factory ResturantDataState.loading() = Loading;
  const factory ResturantDataState.success(T data) = Success<T>;
  const factory ResturantDataState.fail(ApiErrorModel error) = Fail;
  const factory ResturantDataState.changeEnableLoading() = ChangeEnableLoading;
  const factory ResturantDataState.changeEnableSuccess(T data) = ChangeEnableSuccess<T>;
  const factory ResturantDataState.changeEnableFail(ApiErrorModel error) = ChangeEnableFail;
  const factory ResturantDataState.getHomeResLoading() = GetHomeResLoading;
  const factory ResturantDataState.getHomeResSuccess(T data) = GetHomeResSuccess<T>;
  const factory ResturantDataState.getHomeResFail(ApiErrorModel error) = GetHomeResFail;

}
