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
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DelivertoRow extends StatelessWidget {
  DelivertoRow({super.key, this.title, this.addressCity, this.isAdmin});
  final GlobalKey drawerkey = GlobalKey();
  final Widget? title;
  final String? addressCity;
  final bool? isAdmin;

  Future<void> initLocationPermission(BuildContext context) async {
    final phone = await SharedPrefHelper.getString(SharedPrefKeys.userPhone);
    getLocationPermission(context, phone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color:
                        state.themeMode == ThemeMode.dark
                            ? Colors.grey
                            : Colors.black87,
                  ),
                ),
                SizedBox(width: isAdmin == true ? 100.w : 8),
                isAdmin == true
                    ? Text(
                      AppStrings.adminPanel.tr(),
                      style: TextStyles.bimini20W700.copyWith(
                        color: AppColors.primaryDeafult,
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title ??
                            Row(
                              children: [
                                Text(
                                 AppStrings.deliverTo.tr(),
                                  style: TextStyles.bimini14W400White.copyWith(
                                    color:
                                        state.themeMode == ThemeMode.dark
                                            ? Colors.grey
                                            : AppColors.darkGrey,
                                  ),
                                ),
                                horizontalSpace(5),
                                Image.asset(
                                  AppImages.cornerDownRight,
                                  width: 15.w,
                                  color:
                                      state.themeMode == ThemeMode.dark
                                          ? Colors.grey
                                          : null,
                                ),
                              ],
                            ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.addressListScreen);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.locationGrey,
                                width: 12.w,
                                color:
                                    state.themeMode == ThemeMode.dark
                                        ? Colors.grey
                                        : null,
                              ),
                              SizedBox(width: 4),
                              BlocBuilder<
                                CreateAddressCubit,
                                CreateAddressState
                              >(
                                builder: (context, addressState) {
                                  final cubit =
                                      context.read<CreateAddressCubit>();
                                  String addressTitle =
                                      cubit.addresses.isNotEmpty
                                          ? (cubit
                                                      .addresses
                                                      .last
                                                      .addressTitle
                                                      .length >
                                                  30
                                              ? cubit
                                                  .addresses
                                                  .last
                                                  .addressTitle
                                                  .substring(0, 30)
                                              : cubit
                                                      .addresses
                                                      .last
                                                      .addressTitle
                                                      .length >
                                                  20
                                              ? cubit
                                                  .addresses
                                                  .last
                                                  .addressTitle
                                                  .substring(0, 20)
                                              : cubit
                                                  .addresses
                                                  .last
                                                  .addressTitle)
                                          : "No address set";
                                  return Text(
                                    addressCity ?? addressTitle,
                                    style: TextStyles.bimini14W400White
                                        .copyWith(
                                          color:
                                              state.themeMode == ThemeMode.dark
                                                  ? AppColors.grey
                                                  : AppColors.darkGrey,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
