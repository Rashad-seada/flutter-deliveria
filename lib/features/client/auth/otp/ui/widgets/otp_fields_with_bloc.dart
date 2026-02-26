import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/otp/logic/cubit/otp_cubit.dart';
import 'package:delveria/features/client/auth/otp/logic/cubit/otp_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// A StatefulWidget so it owns its TextEditingController lifecycle.
/// The parent should use a GlobalKey<OtpFieldsWithBlocState> to call clearFields().
class OtpFieldsWithBloc extends StatefulWidget {
  const OtpFieldsWithBloc({
    super.key,
    required this.theme,
    this.onCompleted,
    this.onChanged,
  });

  final ThemeState theme;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;

  @override
  State<OtpFieldsWithBloc> createState() => OtpFieldsWithBlocState();
}

class OtpFieldsWithBlocState extends State<OtpFieldsWithBloc> {
  // Controller is fully owned here — no disposal race with the parent.
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Call this from the parent via GlobalKey to clear the OTP field.
  void clearFields() {
    if (mounted) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        return PinCodeTextField(
          appContext: context,
          length: 6,
          controller: _controller,
          autoFocus: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          cursorColor: AppColors.primary,
          keyboardType: TextInputType.number,
          textStyle: TextStyles.bimini16W400Body,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 56,
            fieldWidth: 56,
            activeFillColor:
                widget.theme.themeMode == ThemeMode.dark
                    ? Colors.transparent
                    : AppColors.lightGrey,
            inactiveFillColor:
                widget.theme.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : AppColors.lightGrey,
            selectedFillColor:
                widget.theme.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : AppColors.lightGrey,
            activeColor: AppColors.lightGrey,
            selectedColor:
                widget.theme.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : AppColors.primary,
            inactiveColor: AppColors.lightGrey,
            borderWidth: .2,
          ),
          enableActiveFill: true,
          onChanged: widget.onChanged,
          onCompleted: widget.onCompleted,
        );
      },
    );
  }
}
