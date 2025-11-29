import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'get_all_users_admin_state.freezed.dart';

@freezed
class GetAllUsersAdminState<T> with _$GetAllUsersAdminState {
  const factory GetAllUsersAdminState.initial() = _Initial;
  const factory GetAllUsersAdminState.loading() = Loading;
  const factory GetAllUsersAdminState.success(T data) = Success<T>;
  const factory GetAllUsersAdminState.fail(ApiErrorModel error) = Fail;
  const factory GetAllUsersAdminState.banLoading() = BanLoading;
  const factory GetAllUsersAdminState.banSuccess(T data) = BanSuccess<T>;
  const factory GetAllUsersAdminState.banFail(ApiErrorModel error) = BanFail;
  const factory GetAllUsersAdminState.searchUserLoading() = SearchUserLoading;
  const factory GetAllUsersAdminState.searchUserSuccess(T data) = SearchUserSuccess<T>;
  const factory GetAllUsersAdminState.searchUserFail(ApiErrorModel error) = SearchUserFail;
}
