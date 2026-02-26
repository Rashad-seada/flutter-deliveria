import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/func/show_cancel_dialog.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_state.dart';
import 'package:delveria/features/client/orders/ui/track_order.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color _getStatusColor(String status) {
  switch (status) {
    case "Delivered":
    case "Completed":
    case "Done":
      return Colors.green.withOpacity(0.2);
    case "Canceled":
      return Colors.red.withOpacity(0.2);
    case "Ready for Delivery":
    case "On the way":
    case "Pick up":
       return Colors.blue.withOpacity(0.2);
    default:
      return Colors.orange.withOpacity(0.2);
  }
}

Color _getStatusTextColor(String status) {
   switch (status) {
    case "Delivered":
    case "Completed":
    case "Done":
      return Colors.green;
    case "Canceled":
      return Colors.red;
    case "Ready for Delivery":
    case "On the way":
    case "Pick up":
      return Colors.blue;
    default:
      return Colors.orange;
  }
}

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    super.key,
    required this.restaurantName,
    required this.price,
    required this.orderNumber,
    required this.date,
    required this.items,
    this.isOngoing,
    this.themeState,
    this.newOrders,
    this.orders,
    this.orderStatus,
    this.orderStatusColor,
    this.onTap,
    this.isDeliveryAgent,
    this.shippingPrice,
    this.resId,
    this.orderId,
    required this.isResturant,
    this.time, this.multi,
  });
  final String restaurantName, price, orderNumber, date, items;
  final bool? isOngoing;
  final ThemeState? themeState;
  final bool? newOrders;
  final bool? orders;
  final String? orderStatus;
  final String? time;
  final Color? orderStatusColor;
  final void Function()? onTap;
  final bool? isDeliveryAgent;
  final String? shippingPrice;
  final String? resId;
  final String? orderId;
  final bool isResturant;
  final Widget ? multi;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: themeState?.themeMode == ThemeMode.dark
              ? AppColors.darkGrey
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Icon + Name + Status
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDeafult.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.storefront_outlined,
                    color: AppColors.primaryDeafult,
                    size: 20.sp,
                  ),
                ),
                 horizontalSpace(12),
                Expanded(
                  child: Text(
                    restaurantName,
                    style: TextStyles.bimini16W700.copyWith(fontSize: 16.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                 horizontalSpace(8),
                 if (multi != null) multi!,
                 if (multi != null) horizontalSpace(8),
                
                // Status Chip
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(orderStatus ?? ""),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    orderStatus ?? "Recieved",
                    style: TextStyles.bimini16W400Body.copyWith(
                      color: _getStatusTextColor(orderStatus ?? ""),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            
            verticalSpace(12),
            Divider(color: AppColors.grey.withOpacity(0.2), height: 1),
            verticalSpace(12),

            // Body: Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$orderNumber",
                      style: TextStyles.sen14W400.copyWith(
                        color: themeState?.themeMode == ThemeMode.dark
                            ? AppColors.lightGrey
                            : AppColors.grey,
                         fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      date,
                      style: TextStyles.bimini13W400Grey.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
                
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyles.bimini16W700.copyWith(
                        color: AppColors.primaryDeafult,
                        fontSize: 15.sp,
                      ),
                    ),
                    if (isDeliveryAgent == true && shippingPrice != null)
                     Padding(
                       padding: EdgeInsets.only(top: 4.h),
                       child: Text(
                          shippingPrice!,
                          style: TextStyles.bimini13W400Grey.copyWith(fontSize: 12.sp),
                        ),
                     ),
                  ],
                ),
              ],
            ),

            verticalSpace(12),
            
            // Items
            if (items.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                 color: themeState?.themeMode == ThemeMode.dark
                    ? Colors.black12
                    : AppColors.grey.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(8.r),
              ),
              width: double.infinity,
              child: Text(
                items,
                style: TextStyles.bimini13W400Grey.copyWith(
                  color: themeState?.themeMode == ThemeMode.dark ? Colors.white70 : AppColors.darkGrey,
                  fontSize: 13.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),


            // Actions (Keep Logic)
            if (!(newOrders == true || orders == true) && !isResturant) ...[
               verticalSpace(16),
               BlocBuilder<CarouselCubit, CarouselState>(
                  builder: (context, carouselState) {
                    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
                      builder: (context, state) {
                        final cubit = context.read<GetOrdersCubit>();
                        return TrackOrderButtonRow(
                              showSecond: isOngoing == true ? false : true,
                              fHeight: 38.h,
                              fWidth: isOngoing == true ? 300.w : 148.w, // Fixed width 300.w fits within 318px constraint
                              sOnPressed: () {
                                context.pushNamed(
                                  Routes.addReviewScreen,
                                  arguments: resId,
                                );
                              },
                              fOnPressed:
                                  isOngoing == true
                                      ? orderStatus == "New"
                                          ? () {
                                            showNewDialog(context);
                                          }
                                          : orderStatus == "Canceled"
                                          ? () {
                                            showCanceledDialog(context);
                                          }
                                          : () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => TrackingOrderScreen(
                                                      orderId: orderId ?? "",
                                                      time: formatDate(time),
                                                      initialOrderStatus:
                                                          orderStatus,
                                                    ),
                                              ),
                                            );
                                          }
                                      : () {
                                        final newIndex =
                                            carouselState.selectedIndex + 1;
                                        context
                                            .read<CarouselCubit>()
                                            .updateSelectedIndex(newIndex);
                                        cubit.reorder(orderId: orderId ?? "");
                                        if (state is ReorderSuccess) {
                                          context.pushReplacementNamed(
                                            Routes.bottomBarScreen,
                                            arguments: newIndex,
                                          );
                                        }
                                        print(newIndex);
                                      },
                              ftitle:
                                  isOngoing == true
                                      ? AppStrings.trackOrder.tr()
                                      : AppStrings.reorder.tr(),
                              sHeight: 38.h,
                              sWidth: 140.w,
                              sTitle:
                                  isOngoing == true
                                      ? AppStrings.cancel.tr()
                                      : AppStrings.rate.tr(),
                              themeState: themeState,
                            );
                      },
                    );
                  },
                ),
            ],

          ],
        ),
      ),
    );
  }

  void showNewDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              themeState?.themeMode == ThemeMode.dark
                  ? AppColors.darkGrey
                  : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.orderNew.tr(),
                style: TextStyles.bimini16W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.newDetails.tr(),
                style: TextStyles.bimini14W500,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            AppButton(
              title: AppStrings.done.tr(),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
