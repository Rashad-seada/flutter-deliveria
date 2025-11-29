import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'paymobe_state.freezed.dart';

@freezed
class PaymobeState with _$PaymobeState {
  const factory PaymobeState.initial() = _Initial;
  const factory PaymobeState.loading() = Loading;
  const factory PaymobeState.success() = Success;
  const factory PaymobeState.fail(ApiErrorModel error) = Fail;
}
