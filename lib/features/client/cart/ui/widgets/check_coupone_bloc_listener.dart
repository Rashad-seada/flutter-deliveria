import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CheckCouponeBlocListener extends StatelessWidget {
  const CheckCouponeBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponeCubit, CouponeState>(
      listenWhen:
          (previous, current) =>
              current is CheckSuccess || current is CheckFail,
      buildWhen:
          (previous, current) =>
              current is CheckLoading || current is! CheckLoading,
      builder: (context, state) {
        if (state is CheckLoading ||
            state.maybeWhen(checkLoading: () => true, orElse: () => false)) {
          return LoadingAnimationWidget.newtonCradle(
            color: AppColors.primaryDeafult,
            size: 150.sp,
          );
        }
        return child;
      },
      listener: (context, state) {
        state.whenOrNull(
          checkSuccess: (data) {
            print("😒 will refresh the data ");
            context.read<AddToCartCubit>().getCart();
          },
          checkFail: (error) {
            print(" 🤬 will refresh the data again");
            context.read<AddToCartCubit>().getCart();
          },
        );
      },
    );
  }
}
