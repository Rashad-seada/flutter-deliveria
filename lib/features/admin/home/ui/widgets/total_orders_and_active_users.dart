import 'package:delveria/features/admin/home/ui/widgets/state_card_admin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TotalOrdersAndActiveUsers extends StatelessWidget {
  const TotalOrdersAndActiveUsers({super.key, required this.totalOrders, required this.netRevenue, required this.activeUsers,  this.topRatedResturant});
  final String? totalOrders, netRevenue, activeUsers, topRatedResturant;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        StateCardAdmin(title: 'totalOrders'.tr(), value: totalOrders??""),
        StateCardAdmin(title: 'netRevenue'.tr(), value: netRevenue??""),
        StateCardAdmin(title: 'activeUsers'.tr(), value: activeUsers??""),
        StateCardAdmin(
          title: 'activeResturants'.tr(),
          value: topRatedResturant??"",
        ),
      ],
    );
  }
}
