import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_state.dart';
import 'package:delveria/features/client/profileDrawer/ui/widgets/menu_items_body_drawer.dart';
import 'package:delveria/features/client/profileDrawer/ui/widgets/profile_header_drawer.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key, this.isResturant});
  final bool? isResturant;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Drawer(
          width: 231.w,
          backgroundColor:
              state.themeMode == ThemeMode.dark
                  ? Colors.black
                  : AppColors.lightGrey,
          child: SafeArea(
            child: Column(
              children: [
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create:
                          (context) => getIt<UserDataCubit>()..getUserData(),
                    ),

                    BlocProvider(
                      create:
                          (context) =>
                              getIt<ResturantProfileDataCubit>()
                                ..getResturantProfileData(),
                    ),
                  ],
                  child: ProfileHeaderDrawer(themeState: state),
                ),
                MultiBlocProvider(

                  providers: [
                    BlocProvider(
                      create:
                          (context) => getIt<GetOrdersCubit>()..getOrdersUser(),
                    ), 
                    BlocProvider(
                      create:
                          (context) => getIt<SystemDataCubit>()..getSystemData(),
                    ), 
                  ],
                  child: BlocBuilder<GetOrdersCubit, GetOrdersState>(
                    builder: (context, state) {
                      return MenuItemsBodyDrawer(isResturant: isResturant , orders: context.read<GetOrdersCubit>().orders,);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
