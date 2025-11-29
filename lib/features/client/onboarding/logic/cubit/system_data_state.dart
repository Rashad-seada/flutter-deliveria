import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'system_data_state.freezed.dart';

@freezed
class SystemDataState with _$SystemDataState {
  const factory SystemDataState.initial() = _Initial;
  const factory SystemDataState.loading() = Loading;
  const factory SystemDataState.success() = Success;
  const factory SystemDataState.fail(ApiErrorModel error) = Fail;
}
