import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/ResturantOwner/home/ui/widgets/state_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StateCardRow extends StatelessWidget {
  const StateCardRow({
    super.key,
    required this.totalOrders,
    required this.totalRevenue,
    required this.averageRating,
  });
  final String totalOrders;
  final String totalRevenue;
  final String averageRating;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          StateCard(
            title: 'totalOrders'.tr(),
            value: totalOrders,
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.primary,
            iconBgColor: AppColors.primary.withOpacity(0.1),
          ),
          horizontalSpace(12),
          StateCard(
            title: 'revenue'.tr(),
            value:
                totalRevenue.length > 7
                    ? '${totalRevenue.substring(0, 7)}...'
                    : totalRevenue,
            icon: Icons.account_balance_wallet_outlined,
            iconColor: Colors.green,
            iconBgColor: Colors.green.withOpacity(0.1),
          ),
          horizontalSpace(12),
          StateCard(
            title: 'customerFeedback'.tr(),
            value: '$averageRating/5',
            icon: Icons.star_outline_rounded,
            iconColor: Colors.amber.shade700,
            iconBgColor: Colors.amber.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
