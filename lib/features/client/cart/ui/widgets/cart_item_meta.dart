import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/features/client/cart/data/models/get_cart_response.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:delveria/features/client/cart/ui/widgets/porduct_image.dart';
import 'package:delveria/features/client/cart/ui/widgets/product_details.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeData {
  final String? id;
  final String? size;
  final int? quantity;
  final double? priceOfQuantity;

  SizeData({this.id, this.size, this.quantity, this.priceOfQuantity});
}

class ToppingData {
  final String? id;
  final String? topping;
  final int? quantity;
  final double? priceOfQuantity;

  ToppingData({this.id, this.topping, this.quantity, this.priceOfQuantity});
}

class CartItemMeta {
  final Cart cart;
  final CartData cartData;
  final int cartIndex;
  final CartItem item;
  final int itemIndex;
  final ThemeState themeState;

  CartItemMeta({
    required this.cart,
    required this.cartData,
    required this.cartIndex,
    required this.item,
    required this.itemIndex,
    required this.themeState,
  });
}

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({
    super.key,
    required this.themeState,
    required this.cartData,
    required this.cart,
    required this.item,
  });

  final ThemeState themeState;
  final CartData cartData;
  final Cart cart;
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final itemDetails = item.item_details;
    final items = item;

    String? totalPrice;
    try {
      totalPrice = items.total_price.toString();
    } catch (_) {
      totalPrice = null;
    }

    
    List<SizeData>? sizesWithIds;
    if (items.size_details != null) {
      final sizeDetail = items.size_details;
      
      if (sizeDetail is Map<String, dynamic> && sizeDetail?.id != null) {
        sizesWithIds = [
          SizeData(
            id: sizeDetail?.id,
            size: sizeDetail?.name?? 'Medium', 
            quantity: sizeDetail?.quantity?.toInt(),
            priceOfQuantity: sizeDetail?.price_of_quantity?.toDouble(),
          ),
        ];
      } else if (sizeDetail != null) {
        try {
          sizesWithIds = [
            SizeData(
              id: sizeDetail.id,
              size: sizeDetail.name ?? 'Medium', 
              quantity: sizeDetail.quantity?.toInt(),
              priceOfQuantity: sizeDetail.price_of_quantity?.toDouble(),
            ),
          ];
        } catch (e) {
          print('Error parsing size details: $e');
        }
      }
    }

    List<ToppingData>? toppingsWithIds;
    if (items.topping_details != null && items.topping_details!.isNotEmpty) {
      try {
        toppingsWithIds =
            items.topping_details!
                .map(
                  (toppingDetail) => ToppingData(
                    id: toppingDetail.id,
                    topping: toppingDetail.topping ?? "",
                    quantity: toppingDetail.quantity?.toInt(),
                    priceOfQuantity:
                        toppingDetail.price_of_quantity?.toDouble(),
                  ),
                )
                .toList();
      } catch (e) {
        print('Error parsing topping details: $e');
      }
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: themeState.themeMode == ThemeMode.dark ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: Row(
                children: [
                  ProductImage(img: itemDetails?.photo),
                  horizontalSpace(16),
                  ProductDetails(
                    hint: items.description,
                    itemId: itemDetails?.id ?? "",
                    resturantId: cart.restaurant_details?.id ?? "",
                    totalPrice: totalPrice,
                    name: itemDetails?.name,
                    sizesWithIds: sizesWithIds,
                    itemPrice: state.itemPrice * state.quantity,
                    state: state,
                    themeState: themeState,
                    toppingsWithIds: toppingsWithIds,
                  ),
                  horizontalSpace(10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
