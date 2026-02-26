import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantOrderGroup extends StatelessWidget {
  final dynamic restaurantOrder;

  const RestaurantOrderGroup({Key? key, required this.restaurantOrder})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restName = restaurantOrder.restaurantId.name ?? '';
    final restLogo = restaurantOrder.restaurantId.logo ?? '';
    final restItems = restaurantOrder.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRestaurantHeader(restName, restLogo),
        verticalSpace(10),
        ...restItems.map((item) => OrderItemCard(item: item)),
        verticalSpace(8),
        _buildRestaurantSummary(),
        verticalSpace(20),
      ],
    );
  }

  Widget _buildRestaurantHeader(String name, String logo) {
    final branchName = _getBranchName(restaurantOrder);
    final branchAddress = _getBranchAddress(restaurantOrder);

    return Row(
      children: [
        if (logo.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                logo.startsWith('http')
                    ? logo
                    : "http://62.72.16.178:8550/$logo",
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.restaurant),
              ),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyles.bimini18W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              if (branchName != null && branchName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Icon(Icons.store_outlined, size: 14.sp, color: Colors.grey.shade600),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          branchName,
                          style: TextStyles.bimini14W500.copyWith(color: Colors.grey.shade600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              if (branchAddress != null && branchAddress.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey.shade500),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          branchAddress,
                          style: TextStyles.bimini12W500.copyWith(color: Colors.grey.shade500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Subtotal: ", style: TextStyles.bimini14W500),
        Text(
          "${restaurantOrder.priceOfRestaurant ?? ''} L.E",
          style: TextStyles.bimini14W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
        Spacer(),
        Text("Status: ", style: TextStyles.bimini14W500),
        Text(
          restaurantOrder.status ?? '',
          style: TextStyles.bimini14W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ],
    );
  }

  /// Safely access branch name from either branchId (restaurant model) or branch (agent model)
  String? _getBranchName(dynamic restaurantOrder) {
    try {
      // Try agent model field 'branch' first
      final branch = restaurantOrder.branch;
      if (branch != null) {
        return branch.displayName ?? branch.branchName ?? branch.name;
      }
    } catch (_) {}
    try {
      // Fallback to restaurant model field 'branchId'
      final branchId = restaurantOrder.branchId;
      if (branchId != null) {
        return branchId.branchName ?? branchId.name;
      }
    } catch (_) {}
    return null;
  }

  /// Safely access branch address from either branchId or branch
  String? _getBranchAddress(dynamic restaurantOrder) {
    try {
      final branch = restaurantOrder.branch;
      if (branch != null) return branch.address;
    } catch (_) {}
    try {
      final branchId = restaurantOrder.branchId;
      if (branchId != null) return branchId.address;
    } catch (_) {}
    return null;
  }
}
