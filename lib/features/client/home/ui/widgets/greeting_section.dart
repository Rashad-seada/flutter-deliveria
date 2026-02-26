import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/permissions_function.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Menu (Left) | Deliver To (Center) | Cart (Right)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu Icon (Left)
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkGrey : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.menu,
                  color: isDark ? Colors.white : Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
            
            // Deliver To section (Centered)
            Expanded(
              child: GestureDetector(
                onTap: () => context.pushNamed(Routes.addressListScreen),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStrings.deliverTo.tr(),
                          style: TextStyles.bimini12W400Grey.copyWith(
                            color: isDark ? Colors.grey[400] : AppColors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                        horizontalSpace(4),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16.sp,
                          color: AppColors.primaryDeafult,
                        ),
                      ],
                    ),
                    verticalSpace(2),
                    BlocBuilder<CreateAddressCubit, CreateAddressState>(
                      builder: (context, state) {
                        final cubit = context.read<CreateAddressCubit>();
                        String currentAddress = "Select Address";
                        if (cubit.addresses.isNotEmpty) {
                          currentAddress = cubit.addresses.last.addressTitle ??
                              cubit.addresses.last.details ??
                              "Home";
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14.sp,
                              color: AppColors.primaryDeafult,
                            ),
                            horizontalSpace(4),
                            Flexible(
                              child: Text(
                                currentAddress,
                                style: TextStyles.bimini14W700.copyWith(
                                  color: isDark ? Colors.white : Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Cart Icon (Right)
            BlocBuilder<AddToCartCubit, AddToCartState>(
              buildWhen: (previous, current) {
                return current is GetCartSuccess ||
                    current is IncreaseCartSuccess ||
                    current is DecreaseCartSuccess ||
                    current is RemoveCartSuccess ||
                    current is AddOrderSuccess;
              },
              builder: (context, state) {
                final totalQuantity = context
                    .read<AddToCartCubit>()
                    .itemQuantities
                    .values
                    .fold(0, (sum, qty) => sum + qty);

                return _buildIconButton(
                  icon: AppImages.cartFull,
                  onTap: () => context.pushReplacementNamed(
                      Routes.bottomBarScreen,
                      arguments: 1),
                  isDark: isDark,
                  badgeCount: totalQuantity,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String icon,
    required VoidCallback onTap,
    required bool isDark,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isDark 
              ? AppColors.darkGrey.withOpacity(0.5) 
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(icon, width: 22.w, height: 22.h),
            if (badgeCount > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDeafult,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Center(
                    child: Text(
                      badgeCount > 99 ? '99+' : '$badgeCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
