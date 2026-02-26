import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/animations.dart'; // [NEW] For ScaleOnTap
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/orders/ui/track_order.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveOrderTrackingBar extends StatefulWidget {
  const ActiveOrderTrackingBar({
    super.key,
    required this.order,
    required this.themeState,
  });

  final OrderModel order;
  final ThemeState themeState;

  @override
  State<ActiveOrderTrackingBar> createState() => _ActiveOrderTrackingBarState();
}

class _ActiveOrderTrackingBarState extends State<ActiveOrderTrackingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "delivered":
      case "completed":
      case "done":
        return Colors.green;
      case "canceled":
        return Colors.red;
      case "ready for delivery":
      case "ready_for_delivery":
        return Colors.blue;
      case "on the way":
      case "ontheway":
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case "new":
        return Icons.receipt_long_outlined;
      case "pending":
        return Icons.pending_outlined;
      case "preparing":
        return Icons.restaurant_outlined;
      case "ready for delivery":
      case "ready_for_delivery":
        return Icons.card_giftcard;
      case "on the way":
      case "ontheway":
        return Icons.delivery_dining_outlined;
      case "delivered":
      case "completed":
      case "done":
        return Icons.check_circle_outline;
      case "canceled":
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeState.themeMode == ThemeMode.dark;
    final status = widget.order.status ?? "Pending";
    final statusColor = _getStatusColor(status);

    return ScaleOnTap(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrackingOrderScreen(
              orderId: widget.order.id ?? "",
              time: formatDate(widget.order.createdAt),
              initialOrderStatus: status,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              statusColor.withOpacity(0.15),
              statusColor.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: statusColor.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: statusColor.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Pulsing Status Icon
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  _getStatusIcon(status),
                  color: statusColor,
                  size: 24.sp,
                ),
              ),
            ),
            horizontalSpace(12),
            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.trackOrder.tr(),
                    style: TextStyles.bimini16W700.copyWith(
                      fontSize: 14.sp,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    "Order: #${widget.order.orderId ?? widget.order.id?.substring(0, 8) ?? ''}",
                    style: TextStyles.bimini13W400Grey.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                status,
                style: TextStyles.bimini13W700Deafult.copyWith(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            horizontalSpace(8),
            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: statusColor,
            ),
          ],
        ),
      ),
    );
  }
}
