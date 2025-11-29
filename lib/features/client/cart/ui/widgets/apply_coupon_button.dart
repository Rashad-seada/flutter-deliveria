import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyCouponButton extends StatelessWidget {
  const ApplyCouponButton({super.key, required this.state, required this.onPressed});
  final CartState state;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.w,
      child: AppButton(
        title: state.applyCupone ? AppStrings.removeCoupone.tr() :AppStrings.applyCoupone.tr(),
        onPressed: state.couponeController.text.isEmpty ? null : onPressed,
      ),
    );
  }
}
