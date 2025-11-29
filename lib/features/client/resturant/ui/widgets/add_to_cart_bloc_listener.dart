import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartBlocListener extends StatelessWidget {
  const AddToCartBlocListener({
    super.key,
    required this.child,
    required this.newIndex,
  });
  final Widget child;
  final int newIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToCartCubit, AddToCartState>(
      listenWhen: (previous, current) => current is Success || current is Fail,
      listener: (context, state) {
        state.whenOrNull(
          success: (data) async {
          
            showSuccessSnackBar(context, "Item added to cart successfully");
          
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return AlertDialog(
                      backgroundColor:
                          state.themeMode == ThemeMode.dark
                              ? AppColors.darkGrey
                              : Colors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppStrings.conti.tr(),
                            style: TextStyles.bimini16W700.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          verticalSpace(20),
                          TrackOrderButtonRow(
                            ftitle: AppStrings.shopping.tr(),
                            sTitle: AppStrings.myCart.tr(),
                            fWidth: 120.w,
                            sWidth: 120.w,
                            sOnPressed: () {
                              context.pushReplacementNamed(
                                Routes.bottomBarScreen,
                                arguments: newIndex,
                              );
                            },
                            fOnPressed: () {
                              context.pop();
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          fail: (error) {
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) => current is Loading || current is! Loading,
      builder: (context, state) {
        if (state is Loading ||
            state.maybeWhen(loading: () => true, orElse: () => false)) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
