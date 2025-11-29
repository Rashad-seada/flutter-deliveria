import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'get_home_data_admin_state.freezed.dart';

@freezed
class GetHomeDataAdminState <T> with _$GetHomeDataAdminState {
  const factory GetHomeDataAdminState.initial() = _Initial;
  const factory GetHomeDataAdminState.loading() = Loading;
  const factory GetHomeDataAdminState.success(T data) = Success<T>;
  const factory GetHomeDataAdminState.fail(ApiErrorModel error) = Fail;
}
