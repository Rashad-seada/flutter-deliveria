import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/resturant_admin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddResturantBlocListener extends StatelessWidget {
  const AddResturantBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllresturantsadminCubit, AllresturantsadminState>(
      listenWhen:
          (previous, current) =>
              current is CreateResturantSuccess ||
              current is CreateResturantFail,
      buildWhen:
          (previous, current) =>
              current is CreateResturantLoading ||
              current is! CreateResturantLoading,
      builder: (context, state) {
        if (state is CreateResturantLoading ||
            state.maybeWhen(
              createResturantLoading: () => true,
              orElse: () => false,
            )) {
          return Center(
            child: LoadingAnimationWidget.newtonCradle(
              color: AppColors.primaryDeafult,
              size: 150.sp,
            ),
          );
        }
        return child;
      },
      listener: (context, state) {
        final cubit = context.read<AllresturantsadminCubit>();
        state.whenOrNull(
          createResturantSuccess: (data) {
            showSuccessSnackBar(context, "Resturant Created Successfully ");
            showDialog(
              context: context,
              builder: (context) {
                return RestaurantAdminDialog(
                  userName: cubit.phoneController.text,
                  password: cubit.passwordController.text,
                );
              },
            );
          },
          createResturantFail: (error) {
            print(error.message);
            showErrorSnackBar(context, error.message);
          },
        );
      },
    );
  }
}
