import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'get_orders_state.freezed.dart';

@freezed
class GetOrdersState<T> with _$GetOrdersState {
  const factory GetOrdersState.initial() = _Initial;
  const factory GetOrdersState.loading() = Loading;
  const factory GetOrdersState.success( T data) = Success<T>;
  const factory GetOrdersState.fail(ApiErrorModel error) = Fail;
  const factory GetOrdersState.reorderLoading() = ReorderLoading;
  const factory GetOrdersState.reorderSuccess( T data) = ReorderSuccess<T>;
  const factory GetOrdersState.reorderFail(ApiErrorModel error) = ReorderFail;
}
