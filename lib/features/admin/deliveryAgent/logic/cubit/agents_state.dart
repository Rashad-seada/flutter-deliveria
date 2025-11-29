import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agents_state.freezed.dart';

@freezed
class AgentsState<T> with _$AgentsState {
  const factory AgentsState.initial() = _Initial;
  const factory AgentsState.success(T data) = Success<T>;
  const factory AgentsState.loading() = Loading;
  const factory AgentsState.fail(ApiErrorModel error) = Fail;
  const factory AgentsState.createSuccess(T data) = CreateSuccess<T>;
  const factory AgentsState.createLoading() = CreateLoading;
  const factory AgentsState.createFail(ApiErrorModel error) = CreateFail;
  const factory AgentsState.banAgentSuccess(T data) = BanAgentSuccess<T>;
  const factory AgentsState.banAgentLoading() = BanAgentLoading;
  const factory AgentsState.banAgentFail(ApiErrorModel error) = BanAgentFail;
  const factory AgentsState.getAllOrdersSuccess(T data) = GetAllOrdersSuccess<T>;
  const factory AgentsState.getAllOrdersLoading() = GetAllOrdersLoading;
  const factory AgentsState.getAllOrdersFail(ApiErrorModel error) = GetAllOrdersFail;
  const factory AgentsState.getAllOrdersEachAgentSuccess(T data) = GetAllOrdersEachAgentSuccess<T>;
  const factory AgentsState.getAllOrdersEachAgentLoading() = GetAllOrdersEachAgentLoading;
  const factory AgentsState.getAllOrdersEachAgentFail(ApiErrorModel error) = GetAllOrdersEachAgentFail;
  const factory AgentsState.getEachOrderDetailsSuccess(T data) = GetEachOrderDetailsSuccess<T>;
  const factory AgentsState.getEachOrderDetailsLoading() = GetEachOrderDetailsLoading;
  const factory AgentsState.getEachOrderDetailsFail(ApiErrorModel error) = GetEachOrderDetailsFail;

}
