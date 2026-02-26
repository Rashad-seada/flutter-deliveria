import 'dart:async';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/auth/otp/ui/otp_service.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/do_not_recieve_otp_rich_text.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/otp_fields_with_bloc.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/otp_sent_to_num_text.dart';
import 'package:delveria/features/client/auth/otp/ui/widgets/pipline_error_widget.dart';
import 'package:delveria/features/client/auth/signUp/data/models/sign_up_request_body.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String phone;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  /// The OTP field widget owns the TextEditingController.
  /// We only hold a key to call clearFields() on it.
  final GlobalKey<OtpFieldsWithBlocState> _otpFieldKey =
      GlobalKey<OtpFieldsWithBlocState>();

  late final OTPService _otpService;
  bool _isDisposed = false;

  String _otpCode = '';
  bool _isLoading = false;
  bool _isResending = false;
  String? _lastKnownError;

  Timer? _retryTimer;
  int _retrySeconds = 0;

  void _startRetryTimer(int seconds) {
    _retryTimer?.cancel();
    if (!mounted || _isDisposed) return;
    setState(() {
      _retrySeconds = seconds;
      _isResending = false;
    });
    _retryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _isDisposed) {
        timer.cancel();
        return;
      }
      if (_retrySeconds > 0) {
        setState(() {
          _retrySeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _otpService = OTPService();
    _sendOtp();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _retryTimer?.cancel();
    _otpService.dispose();
    super.dispose();
  }

  /// Send OTP via backend (which uses BeOn SDK)
  void _sendOtp() async {
    if (!mounted || _isDisposed) return;
    setState(() {
      if (!_isResending) _isLoading = true;
      _lastKnownError = null;
    });

    final success = await _otpService.sendOTPToUser(
      widget.phoneNumber,
      onError: (errorMsg, retryAfter) {
        if (!mounted || _isDisposed) return;
        setState(() {
          _lastKnownError = errorMsg;
          _isLoading = false;
          _isResending = false;
        });
        showErrorSnackBar(context, errorMsg);
        if (retryAfter != null) {
          _startRetryTimer(retryAfter);
        }
      },
    );

    if (success) {
      // OTP sent — backend manages it internally
    } else if (mounted && !_isDisposed && _lastKnownError == null) {
      showErrorSnackBar(context, 'Could not send OTP. Please try again.');
    }

    if (mounted && !_isDisposed) {
      setState(() {
        if (!_isResending) _isLoading = false;
      });
    }
  }

  void _handleOtpComplete(String otp) {
    if (!mounted || _isDisposed) return;
    setState(() {
      _otpCode = otp;
    });
    if (otp.length == 6) {
      _verifyOtp();
    }
  }

  void _handleOtpChange(String otp) {
    if (!mounted || _isDisposed) return;
    setState(() {
      _otpCode = otp;
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length != 6) {
      showErrorSnackBar(context, 'Please enter complete OTP code');
      return;
    }

    setState(() {
      _isLoading = true;
      _lastKnownError = null;
    });

    try {
      final isValid = await _otpService.verifyUserOTP(
        widget.phoneNumber,
        _otpCode,
        onError: (errorMsg, remainingAttempts) {
          if (!mounted || _isDisposed) return;
          setState(() {
            _lastKnownError = errorMsg;
          });
          showErrorSnackBar(context, errorMsg);
        },
      );

      if (_lastKnownError != null) {
        _clearOtpFields();
      } else if (isValid) {
        // OTP verified — now sign up the user
        if (!mounted || _isDisposed) return;
        final signupCubit = context.read<SignupCubit>();
        signupCubit.signUp(
          SignUpRequestBody(
            firstName: widget.firstName,
            lastName: widget.lastName,
            email: widget.email,
            password: widget.password,
            phone: widget.phone,
          ),
        );
        showSuccessSnackBar(context, 'OTP verified successfully!');
        if (mounted && !_isDisposed) {
          context.pushNamed(Routes.loginScreen);
        }
      } else {
        showErrorSnackBar(context, 'Invalid OTP code. Please try again.');
        _clearOtpFields();
      }
    } catch (e) {
      debugPrint("OTP verification error: $e");
      if (mounted && !_isDisposed) {
        showErrorSnackBar(context, 'An error occurred. Please try again.');
        _clearOtpFields();
      }
    } finally {
      if (mounted && !_isDisposed) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_isResending || _retrySeconds > 0) return;
    if (!mounted || _isDisposed) return;
    setState(() {
      _isResending = true;
      _lastKnownError = null;
    });

    final success = await _otpService.resendOTP(
      widget.phoneNumber,
      onError: (errorMsg, retryAfter) {
        if (!mounted || _isDisposed) return;
        setState(() {
          _lastKnownError = errorMsg;
          _isResending = false;
        });
        showErrorSnackBar(context, errorMsg);
        if (retryAfter != null) {
          _startRetryTimer(retryAfter);
        }
      },
    );

    if (success) {
      if (mounted && !_isDisposed) {
        showSuccessSnackBar(context, 'OTP resent successfully!');
        setState(() {
          _isResending = false;
          _otpCode = '';
        });
        _otpFieldKey.currentState?.clearFields();
      }
    } else if (mounted && !_isDisposed && _lastKnownError == null) {
      showErrorSnackBar(context, 'Failed to resend OTP. Please try again.');
      setState(() {
        _isResending = false;
      });
    }
  }

  void _clearOtpFields() {
    if (!mounted || _isDisposed) return;
    _otpFieldKey.currentState?.clearFields();
    setState(() {
      _otpCode = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: ArrowBackAppBar(theme: state),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_lastKnownError != null)
                    pipelineErrorWidget(_lastKnownError!),
                  SentOtpToNumberText(phone: widget.phoneNumber),
                  verticalSpace(40),
                  Text(
                    AppStrings.enterOtpCode.tr(),
                    style: TextStyles.bimini16W400Body,
                  ),
                  verticalSpace(15),
                  OtpFieldsWithBloc(
                    key: _otpFieldKey,
                    theme: state,
                    onChanged: _handleOtpChange,
                    onCompleted: _handleOtpComplete,
                  ),
                  verticalSpace(50),
                  Center(
                    child:
                        (_isLoading && !_isResending)
                            ? const CircularProgressIndicator()
                            : AppButton(
                              title: AppStrings.continueText.tr(),
                              onPressed:
                                  (_otpCode.length == 6 &&
                                          !_isLoading &&
                                          _lastKnownError == null &&
                                          !_isResending)
                                      ? _verifyOtp
                                      : null,
                            ),
                  ),
                  verticalSpace(20),
                  InkWell(
                    onTap: (_isResending || _retrySeconds > 0) ? null : _resendOtp,
                    child:
                        _isResending
                            ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                            : Center(
                                child: _retrySeconds > 0
                                    ? Text(
                                        "Resend available in ${_retrySeconds}s",
                                        style: TextStyles.bimini14W700
                                            .copyWith(color: Colors.grey),
                                      )
                                    : DonotRecieveOtpRichText(theme: state),
                              ),
                  ),
                  if (_lastKnownError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 18.h),
                      child: Center(
                        child: Text(
                          "Please contact support or try again later.",
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ),
                  verticalSpace(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
