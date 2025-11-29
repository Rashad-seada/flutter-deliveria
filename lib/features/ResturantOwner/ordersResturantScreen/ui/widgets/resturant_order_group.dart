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
        SizedBox(
          width: 200.w,
          child: Text(
            name,
            style: TextStyles.bimini18W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
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
}
