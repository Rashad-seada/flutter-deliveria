import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/ui/resturant_notification.dart';
import 'package:delveria/features/ResturantOwner/settingsResturant/ui/settings_resturant_screen.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/resturant_admin_screen.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_cubit.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_cubit.dart';
import 'package:delveria/features/admin/users/ui/users_screen.dart';
import 'package:delveria/features/client/profileDrawer/ui/widgets/build_menu_item_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemButtonDrawerAdmin extends StatelessWidget {
  const MenuItemButtonDrawerAdmin({super.key});

  Future<void> _logout(BuildContext context) async {
    await SharedPrefHelper.removeData(SharedPrefKeys.userToken);
    await SharedPrefHelper.clearAllSecuredData();
    context.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      predicate: (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildMenuItemDrawer(
            img: AppImages.resturant,
            title: 'Restaurants',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create:
                                (context) => getIt<AdminResturantFilterCubit>(),
                          ),
                          BlocProvider(
                            create:
                                (context) =>
                                    getIt<AllresturantsadminCubit>()
                                      ..getAllResturantsForAdmin(),
                          ),
                        ],
                        child: ResturantAdminScreen(),
                      ),
                ),
              );
            },
          ),
          buildMenuItemDrawer(
            img: AppImages.notification,
            title: AppStrings.notifications.tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create:
                            (context) =>
                                getIt<NotificationsCubit>()..getNotifications(),
                        child: ResturantNotification(isAdmin: true),
                      ),
                ),
              );
            },
          ),
          buildMenuItemDrawer(
            img: AppImages.usersAdmin,
            title: 'Users',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => getIt<AdminUserFilterCubit>(),
                          ),
                          BlocProvider(
                            create:
                                (context) =>
                                    getIt<GetAllUsersAdminCubit>()
                                      ..getAllUsers(),
                          ),
                          BlocProvider(
                            create: (context) => getIt<NotificationsCubit>(),
                          ),
                        ],
                        child: UsersScreen(),
                      ),
                ),
              );
            },
          ),
          buildMenuItemDrawer(
            img: AppImages.deliveryAgent,
            title: 'Delivery Agent',
            onTap: () {
              context.pushNamed(Routes.deliveryAgentScreen);
            },
          ),
          buildMenuItemDrawer(
            img: AppImages.coupons,
            title: 'Coupons',
            onTap: () {
              context.pushNamed(Routes.adminCoupons);
            },
          ),
          buildMenuItemDrawer(
            img: AppImages.ads,
            title: 'Ads Sliders',
            onTap: () {
              context.pushNamed(Routes.addSliderScreen);
            },
          ),
          buildMenuItemDrawer(
            img: AppImages.settings,
            title: AppStrings.setting.tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsResturantScreen(isAdmin: true),
                ),
              );
            },
          ),

          Divider(
            height: 25.h,
            thickness: 1,
            color: Colors.grey,
            indent: 16.w,
            endIndent: 16.w,
          ),

          // Logout
          buildMenuItemDrawer(
            img: AppImages.logout,
            title: 'Log out',
            onTap: () async {
              await _logout(context);
            },
            showTrailing: false,
          ),
        ],
      ),
    );
  }
}
