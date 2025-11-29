import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboradingCubit, OnboradingState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            await SharedPrefHelper.setData(
              SharedPrefKeys.finishOnBoarding,
              true,
            );
            context.pushNamed(Routes.loginScreen);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            minimumSize: Size(262.w, 44.h),
          ),
          child: Text("التالي ", style: TextStyles.bimini14W400White),
        );
      },
    );
  }
}
