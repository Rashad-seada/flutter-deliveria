import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/state_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StateCardRow extends StatelessWidget {
  const StateCardRow({super.key, required this.totalOrders, required this.totalRevenue});
  final String totalOrders;
  final String totalRevenue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          StateCard(
            title: 'totalOrders'.tr(),
            value: totalOrders,
            change: '+10%',
          ),
          horizontalSpace(16),
          StateCard(
            title: 'revenue'.tr(),
            value:
                totalRevenue.length > 5
                    ? totalRevenue.substring(0, 5)
                    : totalRevenue,
            change: '+10%',
          ),
        ],
      ),
    );
  }
}
