import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final dynamic item;

  const OrderItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemDetails = item.itemDetails;
    final sizeDetails = item.sizeDetails;
    final toppingDetails = item.toppingDetails;

    return Center(
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              itemDetails.name ?? '',
              style: TextStyles.bimini16W700,
              textAlign: TextAlign.center,
            ),
            if ((itemDetails.description ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  itemDetails.description ?? '',
                  style: TextStyles.bimini13W400Grey.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 6),
            Text(
              "Size: ${sizeDetails.size ?? ''} | Qty: ${sizeDetails.quantity ?? 1} | Price: ${sizeDetails.priceAfter ?? ''} L.E",
              style: TextStyles.bimini13W400Grey,
              textAlign: TextAlign.center,
            ),
            if (toppingDetails != null && toppingDetails.isNotEmpty)
              _buildToppings(toppingDetails),
            const SizedBox(height: 4),
            Text(
              "Total Item Price: ${item.totalPrice ?? ''} L.E",
              style: TextStyles.bimini13W400Grey.copyWith(
                color: Colors.black87,
              ),
            ),
            if ((item.description ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "Note: ${item.description}",
                  style: TextStyles.bimini13W400Grey.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildToppings(List<dynamic> toppings) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Toppings:", style: TextStyles.bimini13W700Deafult),
          ...toppings.map(
            (topping) => Text(
              "${topping.topping ?? ''} - ${topping.quantity ?? 1}x - ${topping.price ?? ''} L.E",
              style: TextStyles.bimini13W400Grey,
            ),
          ),
        ],
      ),
    );
  }
}
