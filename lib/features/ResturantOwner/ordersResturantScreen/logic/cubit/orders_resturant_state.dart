import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'orders_resturant_state.freezed.dart';

@freezed
class OrdersResturantState<T> with _$OrdersResturantState {
  const factory OrdersResturantState.initial() = _Initial;
  const factory OrdersResturantState.loading() = Loading;
  const factory OrdersResturantState.success(T data) = Success<T>;
  const factory OrdersResturantState.fail(ApiErrorModel error) = Fail;
}
