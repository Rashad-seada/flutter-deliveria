import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersAppBar extends StatelessWidget {
  const MyOrdersAppBar({
    super.key,
    required TabController tabController,
    required this.themeState,
    required this.onRefreshPressed,
  }) : _tabController = tabController;

  final TabController _tabController;
  final ThemeState themeState;
  final void Function() onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor:
          themeState.themeMode == ThemeMode.dark
              ? Colors.black12
              : Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: onRefreshPressed,
          icon: Icon(Icons.refresh, color: AppColors.primaryDeafult),
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color:
              themeState.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
          size: 20,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        AppStrings.myOrders.tr(),
        style: TextStyles.bimini20W700.copyWith(
          color:
              themeState.themeMode == ThemeMode.dark
                  ? Colors.white
                  : AppColors.primaryDeafult,
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        controller: _tabController,
        labelColor:
            themeState.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.red[800],
        unselectedLabelColor:
            themeState.themeMode == ThemeMode.dark
                ? Colors.grey
                : Colors.grey[600],
        labelStyle: TextStyles.bimini14W500.copyWith(
          color:
              themeState.themeMode == ThemeMode.dark
                  ? Colors.white
                  : AppColors.primaryDeafult,
        ),
        unselectedLabelStyle: TextStyles.bimini14W500.copyWith(
          color:
              themeState.themeMode == ThemeMode.dark
                  ? Colors.grey
                  : AppColors.darkGrey,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: 25.w),
        indicatorColor:
            themeState.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.red[800],
        indicatorWeight: 2,
        dividerColor: AppColors.grey.withValues(alpha: .4),
        tabs: [
          Tab(text: AppStrings.ongoing.tr()),
          Tab(text: AppStrings.history.tr()),
        ],
      ),
    );
  }
}
