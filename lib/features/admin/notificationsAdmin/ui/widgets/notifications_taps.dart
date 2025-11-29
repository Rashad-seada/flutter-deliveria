import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationTabs extends StatelessWidget {
  final TabController tabController;

  const NotificationTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: tabController,
        labelColor: AppColors.primaryDeafult,
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF8B0000),
        labelStyle: TextStyles.bimini16W700,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        dividerColor: AppColors.lightGreySecond,
        tabs: [
          Tab(text: AppStrings.users.tr()),
          Tab(text: AppStrings.resturants.tr()),
        ],
      ),
    );
  }
}
