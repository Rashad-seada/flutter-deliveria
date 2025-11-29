import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'coupone_state.freezed.dart';

@freezed
class CouponeState<T> with _$CouponeState {
  const factory CouponeState.initial() = _Initial;
  const factory CouponeState.loading() = Loading;
  const factory CouponeState.success(T data) = Success<T>;
  const factory CouponeState.fail(ApiErrorModel error) = Fail;
  const factory CouponeState.checkLoading() = CheckLoading;
  const factory CouponeState.checkSuccess(T data) = CheckSuccess<T>;
  const factory CouponeState.checkFail(ApiErrorModel error) = CheckFail;
  const factory CouponeState.getCouponsLoading() = GetCouponsLoading;
  const factory CouponeState.getCouponsSuccess(T data) = GetCouponsSuccess<T>;
  const factory CouponeState.getCouponsFail(ApiErrorModel error) = GetCouponsFail;
  const factory CouponeState.changeStatusLoading() = ChangeStatusLoading;
  const factory CouponeState.changeStatusSuccess(T data) = ChangeStatusSuccess<T>;
  const factory CouponeState.changeStatusFail(ApiErrorModel error) = ChangeStatusFail;
}
