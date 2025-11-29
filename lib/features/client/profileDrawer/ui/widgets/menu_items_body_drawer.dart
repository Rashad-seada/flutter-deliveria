import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/features/ResturantOwner/home/ui/resturant_drawer_body.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/fav/ui/fav_screen.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_state.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/profileDrawer/ui/widgets/build_menu_item_drawer.dart';
import 'package:delveria/features/client/settings/ui/about_us.dart';
import 'package:delveria/features/client/settings/ui/privacy_and_policy.dart';
import 'package:delveria/features/client/settings/ui/terms_and_conditions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemsBodyDrawer extends StatelessWidget {
  const MenuItemsBodyDrawer({super.key, this.isResturant, this.orders});
  final bool? isResturant;
  final List<OrderModel>? orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          isResturant == true
              ? ResturantDrawerBody()
              : UserDrawerBody(orders: orders),
    );
  }
}

class UserDrawerBody extends StatefulWidget {
  const UserDrawerBody({super.key, this.orders});
  final List<OrderModel>? orders;

  @override
  State<UserDrawerBody> createState() => _UserDrawerBodyState();
}

class _UserDrawerBodyState extends State<UserDrawerBody> {
  Future<void> _logout(BuildContext context) async {
    await SharedPrefHelper.removeData(SharedPrefKeys.userToken);
    await SharedPrefHelper.clearAllSecuredData();
    context.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      predicate: (route) => false,
    );
  }

  int _acceptedOrdersCount() {
    if (widget.orders == null) return 0;
    // Assuming 'accepted' status is represented by a string 'accepted'
    return widget.orders!
        .where(
          (order) =>
              order.status != null && order.status.toString() == 'Completed' ||
              order.status.toString().toLowerCase() == "completed",
        )
        .length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    final int acceptedOrders = _acceptedOrdersCount();
    final int maxPoints = 5;
    final double progress =
        maxPoints > 0 ? (acceptedOrders / maxPoints).clamp(0.0, 1.0) : 0.0;

    return BlocBuilder<SystemDataCubit, SystemDataState>(
      builder: (context, state) {
        final cubit = context.read<SystemDataCubit>();
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            buildMenuItemDrawer(
              img: AppImages.accountInfo,
              title: AppStrings.accountInfo.tr(),
              onTap: () {
                context.pushNamed(Routes.accountInfoScreen, arguments: true);
              },
            ),
            buildMenuItemDrawer(
              img: AppImages.myOrder,
              title: AppStrings.myOrders.tr(),
              onTap: () {
                context.pushNamed(Routes.myOrdersScreen);
              },
            ),
            buildMenuItemDrawer(
              leading: SizedBox(
                width: 30,
                height: 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value:
                          (progress.isNaN || progress.isInfinite)
                              ? 0.0
                              : progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      strokeWidth: 4,
                    ),
                    Center(
                      child: Text(
                        '$acceptedOrders/$maxPoints',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: AppStrings.myPoints.tr(),
              onTap: () {
                // context.pushNamed(Routes.myOrdersScreen);
              },
              img: '',
            ),
            buildMenuItemDrawer(
              img: AppImages.myFav,
              title: AppStrings.myFavorites.tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create:
                                  (context) => getIt<FavoriteCubit>()..getFav(),
                            ),
                            BlocProvider(
                              create:
                                  (context) => getIt<AllresturantsadminCubit>(),
                            ),
                          ],
                          child: FavScreen(),
                        ),
                  ),
                );
              },
            ),
            buildMenuItemDrawer(
              img: AppImages.myAdress,
              title: AppStrings.myAddresses.tr(),
              onTap: () {
                context.pushNamed(Routes.addressListScreen);
              },
            ),
            Divider(
              height: 25.h,
              thickness: 1,
              color: Colors.grey,
              indent: 16.w,
              endIndent: 16.w,
            ),
            buildMenuItemDrawer(
              title: AppStrings.setting.tr(),
              onTap: () {
                context.pushNamed(Routes.settingsScreen);
              },
              img: AppImages.settings,
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
            isContinueAsGuest
                ? buildMenuItemDrawer(
                  img: AppImages.logout,
                  title: AppStrings.signIn.tr(),
                  onTap: () {
                    context.pushNamed(Routes.loginScreen);
                  },
                )
                : buildMenuItemDrawer(
                  img: AppImages.logout,
                  title: AppStrings.logOut.tr(),
                  onTap: () async {
                    await _logout(context);
                  },
                  showTrailing: false,
                ),
            isContinueAsGuest
                ? SizedBox()
                : cubit.isUploaded == false
                ? buildMenuItemDrawer(
                  img: AppImages.trach,
                  showTrailing: false,
                  title: AppStrings.deleteAccount.tr(),
                  onTap: () async {
                    await SharedPrefHelper.setData(
                      SharedPrefKeys.isDeleted,
                      true,
                    );
                    print(SharedPrefHelper.getBool(SharedPrefKeys.isDeleted));
                    context.pushNamed(Routes.loginScreen);
                  },
                )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
