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
  final TextEditingController _otpController = TextEditingController();
  late final OTPService _otpService;

  String? _verificationId;
  String _otpCode = '';
  bool _isLoading = false;
  bool _isResending = false;
  String? _lastKnownPipelineError;

  @override
  void initState() {
    super.initState();
    _otpService = OTPService();
    _sendOtp();
  }

  /// Called during screen load and on "resend" -- decoupled from loading button!
  void _sendOtp() async {
    // Only mark as loading during the first load, not during resend.
    // When resending, _isResending will be handled separately!
    setState(() {
      if (!_isResending) _isLoading = true;
      _lastKnownPipelineError = null;
    });

    final id = await _otpService.sendOTPToUser(
      widget.phoneNumber,
      onError: (errorMsg) {
        setState(() {
          _lastKnownPipelineError = errorMsg;
          // Make sure to reset both loading states in error!
          _isLoading = false;
          _isResending = false;
        });
        showErrorSnackBar(context, errorMsg);
      },
    );

    if (id != null) {
      setState(() {
        _verificationId = id;
      });
    } else if (_lastKnownPipelineError == null) {
      showErrorSnackBar(context, 'Could not send OTP. Please try again.');
    }

    setState(() {
      if (!_isResending) _isLoading = false;
      // _isResending is set to false in _resendOtp after context safety!
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpService.dispose();
    super.dispose();
  }

  void _handleOtpComplete(String otp) {
    setState(() {
      _otpCode = otp;
    });
    if (otp.length == 6) {
      _verifyOtp();
    }
  }

  void _handleOtpChange(String otp) {
    setState(() {
      _otpCode = otp;
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length != 6) {
      showErrorSnackBar(context, 'Please enter complete OTP code');
      return;
    }

    if (_verificationId == null) {
      showErrorSnackBar(
        context,
        'No OTP verification available. Please resend OTP.',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _lastKnownPipelineError = null;
    });

    try {
      final isValid = await _otpService.verifyUserOTP(
        _verificationId!,
        _otpCode,
        onError: (errorMsg) {
          setState(() {
            _lastKnownPipelineError = errorMsg;
          });
          showErrorSnackBar(context, errorMsg);
        },
      );
      if (_lastKnownPipelineError != null) {
        _clearOtpFields();
      } else if (isValid) {
        // SIGN UP after OTP verified successfully
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
        // Show success and navigate if needed, or respond to signup state listener
        showSuccessSnackBar(context, 'OTP verified successfully!');
        if (mounted) {
          context.pushNamed(Routes.loginScreen);
        }
      } else {
        showErrorSnackBar(context, 'Invalid OTP code. Please try again.');
        _clearOtpFields();
      }
    } catch (e) {
      print("eeeeeee$e");
      showErrorSnackBar(context, 'An error occurred. Please try again.');
      _clearOtpFields();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_isResending) return; // prevent spamming
    setState(() {
      _isResending = true;
      _lastKnownPipelineError = null;
    });

    final newVerificationId = await _otpService.sendOTPToUser(
      widget.phoneNumber,
      onError: (errorMsg) {
        setState(() {
          _lastKnownPipelineError = errorMsg;
          _isResending = false; // IMPORTANT: reset resending if failed
        });
        showErrorSnackBar(context, errorMsg);
      },
    );

    if (newVerificationId != null) {
      showSuccessSnackBar(context, 'OTP resent successfully!');
      setState(() {
        _verificationId = newVerificationId;
        _isResending = false; // stop the spinner
        // Optionally also clear OTP fields on resend
        _otpController.clear();
        _otpCode = '';
      });
    } else if (_lastKnownPipelineError == null) {
      showErrorSnackBar(context, 'Failed to resend OTP. Please try again.');
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    } else {
      // error callback has already set _isResending = false
    }
  }

  void _clearOtpFields() {
    _otpController.clear();
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_lastKnownPipelineError != null)
                    pipelineErrorWidget(_lastKnownPipelineError!),
                  Expanded(
                    flex: 1,
                    child: SentOtpToNumberText(phone: widget.phoneNumber),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.enterOtpCode.tr(),
                          style: TextStyles.bimini16W400Body,
                        ),
                        verticalSpace(15),
                        OtpFieldsWithBloc(
                          theme: state,
                          controller: _otpController,
                          onChanged: _handleOtpChange,
                          onCompleted: _handleOtpComplete,
                        ),
                        verticalSpace(50),
                        Center(
                          child:
                              (_isLoading && !_isResending)
                                  ? CircularProgressIndicator()
                                  : AppButton(
                                    title: AppStrings.continueText.tr(),
                                    onPressed:
                                        (_otpCode.length == 6 &&
                                                !_isLoading &&
                                                _lastKnownPipelineError ==
                                                    null &&
                                                !_isResending)
                                            ? _verifyOtp
                                            : null,
                                  ),
                        ),
                        verticalSpace(10),
                        // Fix: Use InkWell for better disabled handling and change logic
                        InkWell(
                          onTap:
                              (_isResending ||
                                      (_lastKnownPipelineError != null &&
                                          !_lastKnownPipelineError!.contains(
                                            'pipeline',
                                          )))
                                  ? null
                                  : _resendOtp,
                          child:
                              _isResending
                                  ? Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                  : DonotRecieveOtpRichText(theme: state),
                        ),
                        if (_lastKnownPipelineError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              "Please contact support or try again later.",
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
