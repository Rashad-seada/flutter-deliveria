
import 'package:freezed_annotation/freezed_annotation.dart';
part  'otp_state.freezed.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial() = _Initial;
  const factory OtpState.loading() = Loading;
  const factory OtpState.success() = Success;
  const factory OtpState.error(String message) = Error;
}
