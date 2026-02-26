import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminOrderCard extends StatelessWidget {
  final String restaurantName;
  final String? agentName;
  final String price;
  final String shippingPrice;
  final String orderNumber;
  final String date;
  final int itemsCount;
  final bool isMulti;
  final String? status;

  const AdminOrderCard({
    super.key,
    required this.restaurantName,
    this.agentName,
    required this.price,
    required this.shippingPrice,
    required this.orderNumber,
    required this.date,
    required this.itemsCount,
    this.isMulti = false,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Rest Name + Agent Name
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.storefront_rounded,
                  color: AppColors.primaryDeafult,
                  size: 20.sp,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: TextStyles.bimini16W700.copyWith(fontSize: 15.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (agentName != null && agentName!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Row(
                          children: [
                            Icon(Icons.delivery_dining,
                                size: 14.sp, color: Colors.grey),
                            horizontalSpace(4),
                            Expanded(
                              child: Text(
                                "Agent: $agentName",
                                style: TextStyles.bimini13W400Grey.copyWith(
                                    fontSize: 12.sp, color: Colors.grey[600]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (isMulti)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.orange.withOpacity(0.5)),
                  ),
                  child: Text(
                    "Multi",
                    style: TextStyles.bimini12W400Grey.copyWith(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
            ],
          ),
          verticalSpace(12),
          Divider(color: Colors.grey.withOpacity(0.1), height: 1),
          verticalSpace(12),

          // Body: Pricing & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style: TextStyles.bimini12W400Grey,
                  ),
                  Text(
                    "$price L.E",
                    style: TextStyles.bimini16W700.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.primaryDeafult,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Shipping",
                    style: TextStyles.bimini12W400Grey,
                  ),
                  Text(
                    shippingPrice == "0" ? "Free" : "$shippingPrice L.E",
                    style: TextStyles.bimini14W500.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          verticalSpace(12),

          // Footer: Order ID, Date, Item Count
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.tag, size: 14.sp, color: Colors.grey),
                    horizontalSpace(4),
                    Text(
                      "#${orderNumber.length > 5 ? orderNumber.substring(0, 5) : orderNumber}", // Shorten ID
                      style: TextStyles.sen14W400.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14.sp, color: Colors.grey),
                    horizontalSpace(4),
                    Text(
                      formatDate(date),
                      style: TextStyles.bimini12W400Grey.copyWith(
                          fontSize: 11.sp),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.layers_outlined,
                        size: 14.sp, color: Colors.grey),
                    horizontalSpace(4),
                    Text(
                      "$itemsCount Items",
                      style: TextStyles.bimini12W400Grey.copyWith(
                          fontSize: 11.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
