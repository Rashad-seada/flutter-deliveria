import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/orders/logic/cubit/order_cubit.dart';
import 'package:delveria/features/client/orders/ui/widgets/build_order_step.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:delveria/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveredOnBody extends StatefulWidget {
  const DeliveredOnBody({
    super.key,
    required this.time,
    required this.initialStatus,
  });
  final String time;
  final String initialStatus;

  @override
  State<DeliveredOnBody> createState() => _DeliveredOnBodyState();
}

class _DeliveredOnBodyState extends State<DeliveredOnBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Column(
          children: [
            // Header card with delivery time info
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryDeafult.withOpacity(0.08),
                    AppColors.primaryDeafult.withOpacity(0.03),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColors.primaryDeafult.withOpacity(0.15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeafult.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.local_shipping_rounded,
                      size: 22.sp,
                      color: AppColors.primaryDeafult,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.deliverOn.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: themeState.themeMode == ThemeMode.dark
                                ? AppColors.lightGrey
                                : Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          AppStrings.halfHour.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDeafult,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusChipColor(),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      _getStatusLabel(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress indicator bar
            BlocBuilder<OrderCubit, dynamic>(
              builder: (context, state) {
                final progress = (state.currentStep + 1) /
                    state.orderSteps.length;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            "${(progress * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDeafult,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progress >= 1.0
                                ? const Color(0xFF2ECC71)
                                : AppColors.primaryDeafult,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 16.h),

            // Steps timeline list
            Expanded(
              child: BlocBuilder<OrderCubit, dynamic>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: state.orderSteps.length,
                    itemBuilder: (context, index) {
                      return BuildOrderStep(
                        index: index,
                        themeState: themeState,
                        time: widget.time,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusChipColor() {
    final status = widget.initialStatus.toLowerCase();
    if (status.contains("delivered") || status.contains("completed")) {
      return const Color(0xFF2ECC71);
    }
    if (status.contains("canceled") || status.contains("cancelled")) {
      return Colors.red;
    }
    if (status.contains("on the way") ||
        status.contains("pick up") ||
        status.contains("out for delivery") ||
        status.contains("in transit") ||
        status.contains("shipped")) {
      return const Color(0xFF3498DB);
    }
    if (status.contains("ready")) {
      return const Color(0xFF9B59B6);
    }
    if (status.contains("preparing") || status.contains("approved")) {
      return const Color(0xFFE67E22);
    }
    return const Color(0xFFFF9800);
  }

  String _getStatusLabel() {
    if (widget.initialStatus.isEmpty) return "In Progress";
    return widget.initialStatus;
  }
}
