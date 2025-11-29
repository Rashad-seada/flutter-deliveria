import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'agent_orders_state.freezed.dart';

@freezed
class AgentOrdersState<T> with _$AgentOrdersState {
  const factory AgentOrdersState.initial() = _Initial;
  const factory AgentOrdersState.loading() = Loading;
  const factory AgentOrdersState.success(T data) = Success<T>;
  const factory AgentOrdersState.fail(ApiErrorModel error) = Fail;
  const factory AgentOrdersState.acceptOrderLoading() = AcceptOrderLoading;
  const factory AgentOrdersState.acceptOrderSuccess(T data) = AcceptOrderSuccess<T>;
  const factory AgentOrdersState.acceptOrderFail(ApiErrorModel error) = AcceptOrderFail;
  const factory AgentOrdersState.getAcceptOrderLoading() = GetAcceptOrderLoading;
  const factory AgentOrdersState.getAcceptOrderSuccess(T data) = GetAcceptOrderSuccess<T>;
  const factory AgentOrdersState.getAcceptOrderFail(ApiErrorModel error) = GetAcceptOrderFail;
  const factory AgentOrdersState.updateOrderStatusAgentLoading() = UpdateOrderStatusAgentLoading;
  const factory AgentOrdersState.updateOrderStatusAgentSuccess(T data) = UpdateOrderStatusAgentSuccess<T>;
  const factory AgentOrdersState.updateOrderStatusAgentFail(ApiErrorModel error) = UpdateOrderStatusAgentFail;
  const factory AgentOrdersState.acceptOrderResLoading() = AcceptOrderResLoading;
  const factory AgentOrdersState.acceptOrderResSuccess(T data) = AcceptOrderResSuccess<T>;
  const factory AgentOrdersState.acceptOrderResFail(ApiErrorModel error) = AcceptOrderResFail;
  const factory AgentOrdersState.readyForPickUpLoading() = ReadyForPickUpLoading;
  const factory AgentOrdersState.readyForPickUpSuccess(T data) = ReadyForPickUpSuccess<T>;
  const factory AgentOrdersState.readyForPickUpFail(ApiErrorModel error) = ReadyForPickUpFail;

}
