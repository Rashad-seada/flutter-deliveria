import 'package:delveria/features/client/auth/otp/logic/cubit/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(const OtpState.initial());

   TextEditingController otpController = TextEditingController();
  String otpText = '';



  void onResendOtp() {
    // TODO: Implement your resend OTP logic here
    // This would likely be an async call to a repository
    debugPrint("OTP Resent");
  }
  void updateOtpText(String text) {
    otpText = text;
  }

  @override
  Future<void> close() {
    otpController.dispose();
    return super.close();
  }
}
