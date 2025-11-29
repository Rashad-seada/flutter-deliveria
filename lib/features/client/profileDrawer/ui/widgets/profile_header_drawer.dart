import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_state.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeaderDrawer extends StatelessWidget {
  const ProfileHeaderDrawer({super.key, required this.themeState});
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        final cubit = context.read<UserDataCubit>();
        return BlocBuilder<
          ResturantProfileDataCubit,
          ResturantProfileDataState
        >(
          builder: (context, state) {
            final resturantCubit = context.read<ResturantProfileDataCubit>();

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor:
                          themeState.themeMode == ThemeMode.dark
                              ? Colors.grey.withValues(alpha: .3)
                              : AppColors.userBackGroundColor.withValues(
                                alpha: .2,
                              ),
                      backgroundImage:
                          resturantCubit.photo?.isNotEmpty==true
                              ? CachedNetworkImageProvider(
                                "${ApiConstants.baseUrl}/${resturantCubit.photo}",
                              )
                              : AssetImage(AppImages.person),
                    ),
                    horizontalSpace(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            resturantCubit.name.isNotEmpty
                                ? resturantCubit.name
                                : "${cubit.firstName}${cubit.lastName}",
                            style: TextStyles.bimini16W400Body.copyWith(
                              color:
                                  themeState.themeMode == ThemeMode.dark
                                      ? AppColors.lightGrey.withValues(
                                        alpha: .9,
                                      )
                                      : Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          resturantCubit.address.isNotEmpty
                              ? resturantCubit.address.substring(1, 20)
                              : cubit.email,
                          style: TextStyles.bimini12W400Grey.copyWith(
                            color:
                                themeState.themeMode == ThemeMode.dark
                                    ? AppColors.lightGrey.withValues(alpha: .8)
                                    : AppColors.darkGrey,
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
      },
    );
  }
}
