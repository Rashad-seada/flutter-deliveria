import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/add_items_category_screen.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/ui/resturant_notification.dart';
import 'package:delveria/features/client/profileDrawer/ui/widgets/build_menu_item_drawer.dart';
import 'package:delveria/features/client/settings/ui/about_us.dart';
import 'package:delveria/features/client/settings/ui/privacy_and_policy.dart';
import 'package:delveria/features/client/settings/ui/terms_and_conditions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantDrawerBody extends StatelessWidget {
  const ResturantDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildMenuItemDrawer(
          title: AppStrings.setting.tr(),
          onTap: () {
            context.pushNamed(Routes.settingsResturantScreen);
          },
          img: AppImages.settings,
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
                      child: ResturantNotification(isRestaurant: true),
                    ),
              ),
            );
          },
        ),
        buildMenuItemDrawer(
          img: AppImages.editGreen,
          title: AppStrings.addItemCategories.tr(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => BlocProvider(
                      create: (context) => getIt<ItemCubit>()..getItemCategories(),
                      child: AddItemsCategoryScreen(),
                    ),
              ),
            );
          },
        ),
        buildMenuItemDrawer(
          img: AppImages.aboutUs,
          title: AppStrings.aboutUs.tr(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AboutUsScreen()),
            );
          },
        ),
        buildMenuItemDrawer(
          img: AppImages.privacy,
          title: AppStrings.privacyAndPolicy.tr(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PrivacyAndPolicyScreen()),
            );
          },
        ),
        buildMenuItemDrawer(
          img: AppImages.terms,
          title: AppStrings.termsAndConditions.tr(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TermsAndConditionsScreen()),
            );
          },
        ),

        Divider(
          height: 20.h,
          thickness: 1,
          color: Colors.grey,
          indent: 16.w,
          endIndent: 16.w,
        ),

        // Logout
        buildMenuItemDrawer(
          img: AppImages.logout,
          title: AppStrings.logOut.tr(),
          onTap: () {
            context.pushNamedAndRemoveUntil(
              Routes.loginScreen,
              predicate: (route) => false,
            );
          },
          showTrailing: false,
        ),
      ],
    );
  }
}
