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
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: themeState?.themeMode == ThemeMode.dark
              ? AppColors.darkGrey
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.primaryDeafult,
                  child: Icon(
                    Icons.shopping_basket_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orders == true
                          ? Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: Text(
                                  restaurantName,
                                  style: TextStyles.bimini16W700,
                                ),
                              ),
                              Spacer(),
                              multi ?? SizedBox(),
                              horizontalSpace(10),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                width: 104.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: orderStatusColor,
                                  borderRadius: BorderRadius.circular(
                                    isDeliveryAgent == true ? 4 : 0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    orderStatus ?? "Recieved",
                                    style: TextStyles.bimini16W400Body.copyWith(
                                      color:
                                          orderStatus == "Completed" ||
                                                  orderStatus == "Done"
                                              ? AppColors.darkGrey
                                              : null,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                          : isDeliveryAgent == true
                          ? Row(
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  restaurantName,
                                  style: TextStyles.bimini16W700,
                                ),
                              ),
                              
                            ],
                          )
                          : Row(
                            children: [
                              Text(orderNumber, style: TextStyles.bimini16W700),
                              Spacer(),
                              orderStatus!="Completed"?  Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                width: 104.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: orderStatusColor,
                                  borderRadius: BorderRadius.circular(
                                   4 
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    orderStatus ?? "Recieved",
                                    style: TextStyles.bimini16W400Body.copyWith(
                                      color:
                                          orderStatus == "Completed" ||
                                                  orderStatus == "Done"
                                              ? AppColors.darkGrey
                                              : null,
                                    ),
                                  ),
                                ),
                              ):
                              orderStatus == "Completed"
                                  ? Text(
                                    "Done",
                                    style: TextStyles.bimini14W700.copyWith(
                                      color: AppColors.green,
                                    ),
                                  )
                                  : SizedBox(),
                            ],
                          ),
                      verticalSpace(isDeliveryAgent == true ? 16 : 7),
                      isDeliveryAgent == true
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                shippingPrice ?? "",
                                style: TextStyles.bimini13W700Deafult.copyWith(
                                  color:
                                      themeState?.themeMode == ThemeMode.dark
                                          ? AppColors.lightGrey
                                          : AppColors.darkGrey,
                                ),
                              ),
                              Text(
                                price,
                                style: TextStyles.bimini13W700Deafult.copyWith(
                                  color:
                                      themeState?.themeMode == ThemeMode.dark
                                          ? AppColors.lightGrey
                                          : AppColors.darkGrey,
                                ),
                              ),
                            ],
                          )
                          : Text(
                            price,
                            style: TextStyles.bimini13W700Deafult.copyWith(
                              color:
                                  themeState?.themeMode == ThemeMode.dark
                                      ? AppColors.lightGrey
                                      : AppColors.darkGrey,
                            ),
                          ),
                      verticalSpace(isDeliveryAgent == true ? 16 : 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              orderNumber,
                              style: TextStyles.sen14W400.copyWith(
                                color:
                                    themeState?.themeMode == ThemeMode.dark
                                        ? AppColors.grey
                                        : AppColors.darkGrey,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            horizontalSpace(5),
                            SizedBox(height: 20.h, child: VerticalDivider()),
                            horizontalSpace(5),
                            Text(date, style: TextStyles.bimini13W400Grey),
                            horizontalSpace(5),
                            SizedBox(height: 20.h, child: VerticalDivider()),
                            horizontalSpace(10),
                            Text(items, style: TextStyles.bimini13W400Grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(height: newOrders == true ? 0 : 16),
            newOrders == true || orders == true
                ? SizedBox()
                : BlocBuilder<CarouselCubit, CarouselState>(
                  builder: (context, carouselState) {
                    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
                      builder: (context, state) {
                        final cubit = context.read<GetOrdersCubit>();
                        return isResturant
                            ? SizedBox()
                            : TrackOrderButtonRow(
                              showSecond: isOngoing == true ? false : true,
                              fHeight: 38.h,
                              fWidth: isOngoing == true ? 300.w : 148.w,
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
                              sWidth: 148.w,
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
