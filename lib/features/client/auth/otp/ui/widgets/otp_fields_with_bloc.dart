import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/auth/otp/logic/cubit/otp_cubit.dart';
import 'package:delveria/features/client/auth/otp/logic/cubit/otp_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpFieldsWithBloc extends StatelessWidget {
  const OtpFieldsWithBloc({
    super.key,
    required this.theme,
    required this.controller,
    this.onCompleted,
    this.onChanged,
  });
  final ThemeState theme;
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        final cubit = context.read<OtpCubit>();
        return PinCodeTextField(
          appContext: context,
          length: 6,
          controller: controller,
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
                theme.themeMode == ThemeMode.dark
                    ? Colors.transparent
                    : AppColors.lightGrey,
            inactiveFillColor:
                theme.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : AppColors.lightGrey,
            selectedFillColor:
                theme.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : AppColors.lightGrey,
            activeColor: AppColors.lightGrey,
            selectedColor:
                theme.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : AppColors.primary,
            inactiveColor: AppColors.lightGrey,
            borderWidth: .2,
          ),
          enableActiveFill: true,
          onChanged: onChanged,
          onCompleted: onCompleted,
        );
      },
    );
  }
}
