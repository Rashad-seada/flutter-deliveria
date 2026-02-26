import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/guest_login_dialog.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_state.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/data/models/notifications_model.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarBloc extends StatelessWidget {
  const BottomNavBarBloc({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themestate) {
            final isDark = themestate.themeMode == ThemeMode.dark;

            return CurvedNavigationBar(
              index: selectedIndex,
              height: 70,
              backgroundColor:
                  isDark
                      ? Colors.black12
                      : AppColors.lightGrey,
              color:
                  isDark
                      ? AppColors.primaryDarkMode
                      : Colors.white,

              buttonBackgroundColor:
                  isDark
                      ? AppColors.primaryDeafultDarkMode
                      : const Color(0xFFB71C1C),
              animationDuration: const Duration(milliseconds: 300),
              items: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    selectedIndex == 0
                        ? AppImages.homeWhite
                        : AppImages.homeGrey,
                    width: 30.w,
                    height: selectedIndex == 0 ? 25.h : 20.h,
                    fit: BoxFit.scaleDown,
                    color:
                        isDark
                            ? Colors.white
                            : null,
                  ),
                ),
                // Cart Icon with Badge
                BlocBuilder<AddToCartCubit, AddToCartState>(
                  buildWhen: (previous, current) {
                    return current is GetCartSuccess ||
                        current is IncreaseCartSuccess ||
                        current is DecreaseCartSuccess ||
                        current is RemoveCartSuccess ||
                        current is AddOrderSuccess;
                  },
                  builder: (context, cartState) {
                     // Calculate total quantity from the cached map in Cubit
                    final totalQuantity = context
                        .read<AddToCartCubit>()
                        .itemQuantities
                        .values
                        .fold(0, (sum, qty) => sum + qty);

                    return _buildBadgedIcon(
                      count: totalQuantity,
                      isSelected: selectedIndex == 1,
                      activeIcon: AppImages.cartWhite,
                      inactiveIcon: AppImages.cartGrey,
                      isDark: isDark,
                    );
                  },
                ),
                // Notification Icon with Badge
                BlocBuilder<NotificationsCubit, NotificationsState>(
                  buildWhen: (previous, current) {
                    return current.maybeWhen(
                      success: (_) => true,
                      createSuccess: (_) => true,
                      orElse: () => false,
                    );
                  },
                  builder: (context, notifState) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        selectedIndex == 2
                            ? AppImages.notificationWhite
                            : AppImages.notificationGrey,
                        width: 30.w,
                        height: 20.h,
                        fit: BoxFit.scaleDown,
                        color: isDark ? Colors.white : null,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    selectedIndex == 3
                        ? AppImages.personWhite
                        : AppImages.personGrey,
                    width: 30.w,
                    height: 20.h,
                    fit: BoxFit.scaleDown,
                    color:
                        isDark
                            ? Colors.white
                            : null,
                  ),
                ),
              ],
              onTap: (index) async {
                final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
                // 1= Cart (Guest Can access now), 2= Notifications, 3= Profile
                if (isGuest && (index == 2 || index == 3)) {
                   if (context.mounted) {
                     showGuestLoginDialog(context, message: "Please login to view notifications and manage your profile.");
                   }
                   return; // Stop navigation
                }
                if (context.mounted) {
                  context.read<CarouselCubit>().updateSelectedIndex(index);
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildBadgedIcon({
    required int count,
    required bool isSelected,
    required String activeIcon,
    required String inactiveIcon,
    required bool isDark,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            isSelected ? activeIcon : inactiveIcon,
            width: isSelected ? 30.w : 20.w, // Slightly larger if selected as per original logic for home
            height: 20.h,
            fit: BoxFit.scaleDown,
            color: isDark ? Colors.white : null,
          ),
        ),
        if (count > 0)
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red, // Red circle
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
