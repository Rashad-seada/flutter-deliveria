import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_state.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/coupon_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponInformation extends StatelessWidget {
  const CouponInformation({
    super.key,
    required this.widget,
    required this.pickDateState,
    required this.index, required this.couponStateText,
  });

  final CouponCard widget;
  final PickDateState pickDateState;
  final int index;
  final String couponStateText;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(widget.coupon.expiredDate);
    final restaurants = widget.coupon.applicableRestaurants.isEmpty 
        ? 'All' 
        : widget.coupon.applicableRestaurants.join(', ');

    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(couponStateText, style: TextStyles.bimini13W400Grey),
          verticalSpace(4),
          Text(
            '${AppStrings.couponCode}: ${widget.coupon.code}',
            style: TextStyles.bimini16W700,
          ),
          verticalSpace(4),
          Text(
            '${AppStrings.expDate}: $formattedDate',
            style: TextStyles.bimini16W400Body.copyWith(color: AppColors.grey),
          ),
          Text(
            '${AppStrings.discount.tr()}: ${widget.coupon.value}%',
            style: TextStyles.bimini16W400Body.copyWith(color: AppColors.grey),
          ),
          Text(
            '${AppStrings.resturants.tr()}: $restaurants',
            style: TextStyles.bimini16W400Body.copyWith(color: AppColors.grey),
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}
