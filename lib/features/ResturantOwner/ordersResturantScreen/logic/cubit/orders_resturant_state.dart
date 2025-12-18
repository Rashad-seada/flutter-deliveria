import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'orders_resturant_state.freezed.dart';

@freezed
class OrdersResturantState<T> with _$OrdersResturantState {
  const factory OrdersResturantState.initial() = _Initial;
  const factory OrdersResturantState.loading() = Loading;
  const factory OrdersResturantState.success(T data) = Success<T>;
  const factory OrdersResturantState.fail(ApiErrorModel error) = Fail;
  
  // Accept Order States
  const factory OrdersResturantState.acceptOrderLoading() = AcceptOrderLoading;
  const factory OrdersResturantState.acceptOrderSuccess(T data) = AcceptOrderSuccess<T>;
  const factory OrdersResturantState.acceptOrderFail(ApiErrorModel error) = AcceptOrderFail;
  
  // Mark Ready States
  const factory OrdersResturantState.markReadyLoading() = MarkReadyLoading;
  const factory OrdersResturantState.markReadySuccess(T data) = MarkReadySuccess<T>;
  const factory OrdersResturantState.markReadyFail(ApiErrorModel error) = MarkReadyFail;
}
