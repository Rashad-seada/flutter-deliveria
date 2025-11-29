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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreetingSection extends StatefulWidget {
  const GreetingSection({super.key});

  @override
  State<GreetingSection> createState() => _GreetingSectionState();
}

class _GreetingSectionState extends State<GreetingSection> {
  Future<void> initLocationPermission(BuildContext context) async {
    final phone = await SharedPrefHelper.getString(SharedPrefKeys.userPhone);
    getLocationPermission(context, phone);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.userBackGroundColor.withOpacity(0.2),
          backgroundImage: ExactAssetImage(AppImages.person),
        ),
        const SizedBox(width: 12),
        BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            final cubit = context.read<UserDataCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.goodMorning.tr(),
                  style: TextStyles.bimini12W400Grey,
                ),

                Text(
                  isContinueAsGuest
                      ? "Guest"
                      : "${cubit.firstName} ${cubit.lastName}",
                  style: TextStyles.bimini16W400Body,
                ),
              ],
            );
          },
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.addressListScreen);
          },
          child: Image.asset(AppImages.locationAdd, width: 24.w, height: 24.h),
        ),
        horizontalSpace(10),
        GestureDetector(
          onTap: () {
            context.pushReplacementNamed(Routes.bottomBarScreen, arguments: 1);
          },
          child: Image.asset(AppImages.cartFull, width: 20.w, height: 20.h),
        ),
      ],
    );
  }
}
