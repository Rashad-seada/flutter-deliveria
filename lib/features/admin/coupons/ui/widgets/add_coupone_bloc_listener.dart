import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCouponeBlocListener extends StatelessWidget {
  const AddCouponeBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponeCubit, CouponeState>(
      listenWhen: (previous, current) => current is Success || current is Fail,
      buildWhen:
          (previous, current) => current is Loading || current is! Loading,
      builder: (context, state) {
        if (state is Loading ||
            state.maybeWhen(loading: () => true, orElse: () => false)) {
          return LoadingAnimationWidget.newtonCradle(
            color: AppColors.primaryDeafult,
            size: 150.sp,
          );
        }
        return child;
      },
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            showSuccessSnackBar(context, "Coupone Created Successfully");
          },
          fail: (error) {
            showErrorSnackBar(context, "Failed To Create Coupone ");
          },
        );
      },
    );
  }
}
