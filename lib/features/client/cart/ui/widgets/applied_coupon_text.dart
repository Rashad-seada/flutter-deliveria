import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:flutter/material.dart';

class AppliedCouponText extends StatelessWidget {
  const AppliedCouponText({super.key, required this.state, required this.couponeCubit});
  final CartState state;
  final CouponeCubit couponeCubit;
  @override
  Widget build(BuildContext context) {
    return Text(
      couponeCubit.messageOfCheck,
      style: TextStyles.bimini16W400Body.copyWith(
        color:
            couponeCubit.messageOfCheck.contains(" doesn't")
                ? AppColors.primaryDeafult: AppColors.green
                
      ),
    );
  }
}
