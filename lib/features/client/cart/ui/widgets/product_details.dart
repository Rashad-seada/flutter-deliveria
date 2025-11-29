import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_state.dart';
import 'package:delveria/features/client/cart/ui/widgets/cart_item_meta.dart';
import 'package:delveria/features/client/cart/ui/widgets/increase_and_decrease_bloc_listener.dart';
import 'package:delveria/features/client/cart/ui/widgets/quantity_controllers.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.itemPrice,
    this.name,
    this.sizesWithIds,
    this.toppingsWithIds,
    this.totalPrice,
    required this.state,
    required this.themeState,
    required this.resturantId,
    required this.itemId,
    this.hint,
  });

  final double itemPrice;
  final String? name;
  final String? hint;
  final List<SizeData>? sizesWithIds;
  final List<ToppingData>? toppingsWithIds;
  final String? totalPrice;
  final CartState state;
  final ThemeState themeState;
  final String resturantId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    // Find the selected sizeId to use for toppings increase
    String? selectedSizeId;
    if (sizesWithIds != null && sizesWithIds!.isNotEmpty) {
      selectedSizeId = sizesWithIds!.first.id;
    }

    return Expanded(
      child: IncreaseAndDecreaseBlocListener(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      name ?? AppStrings.classicBurger.tr(),
                      style: TextStyles.bimini20W700,
                    ),
                  ),
                  // Spacer(),
                  BlocBuilder<AddToCartCubit, AddToCartState>(
                    builder: (context, cartState) {
                      if (cartState is RemoveCartLoading) {
                        return CustomLoading();
                      }
                      final cubit = context.read<AddToCartCubit>();
                      return GestureDetector(
                        onTap: () {
                          cubit.removeCart(
                            body: {
                              "restaurant_id": resturantId,
                              "item_id": itemId,
                              "size": sizesWithIds?.first.id,
                            },
                          );
                        },
                        child: Image.asset(
                          AppImages.trach,
                          width: 30.w,
                          height: 20.h,
                          color: AppColors.primaryDeafult,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (sizesWithIds != null && sizesWithIds!.isNotEmpty)
              BlocBuilder<AddToCartCubit, AddToCartState>(
                builder: (context, cartState) {
                  final cartCubit = context.read<AddToCartCubit>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...sizesWithIds!.asMap().entries.map((entry) {
                        final index = entry.key;
                        final sz = entry.value;

                        final quantity = cartCubit.getItemQuantity(
                          itemId: itemId,
                          sizeId: sz.id,
                        );

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 110.w,
                                child: Text(
                                  sz.size ?? AppStrings.mediumSize.tr(),
                                  style: TextStyles.bimini16W400Body,
                                ),
                              ),
                              QuantityControllers(
                                onIncreaseTap: () {
                                  cartCubit.increaseCartItem(
                                    body: {
                                      "restaurant_id": resturantId,
                                      "item_id": itemId,
                                      "size": sz.id,
                                    },
                                    itemIndex: index,
                                    itemId: itemId,
                                    sizeId: sz.id,
                                  );
                                },
                                onDecreaseTap: () {
                                  cartCubit.decreaseCartItem(
                                    body: {
                                      "restaurant_id": resturantId,
                                      "item_id": itemId,
                                      "size": sz.id,
                                    },
                                    itemIndex: index,
                                    itemId: itemId,
                                    sizeId: sz.id,
                                  );
                                },
                                state: state,
                                themeState: themeState,
                                showTrach: false,
                                quantity: quantity,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                },
              )
            else
              BlocBuilder<AddToCartCubit, AddToCartState>(
                builder: (context, cartState) {
                  final cartCubit = context.read<AddToCartCubit>();
                  final quantity = cartCubit.getItemQuantity(itemId: itemId);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.mediumSize.tr(),
                        style: TextStyles.bimini16W400Body,
                      ),
                      QuantityControllers(
                        quantity: quantity,
                        onIncreaseTap: () {
                          cartCubit.increaseCartItem(
                            body: {
                              "restaurant_id": resturantId,
                              "item_id": itemId,
                            },
                            itemIndex: 0,
                            itemId: itemId,
                          );
                        },
                        onDecreaseTap: () {
                          cartCubit.decreaseCartItem(
                            body: {
                              "restaurant_id": resturantId,
                              "item_id": itemId,
                            },
                            itemIndex: 0,
                            itemId: itemId,
                          );
                        },
                        state: state,
                        themeState: themeState,
                        showTrach: false,
                      ),
                    ],
                  );
                },
              ),
            verticalSpace(10),
            if (toppingsWithIds != null && toppingsWithIds!.isNotEmpty)
              BlocBuilder<AddToCartCubit, AddToCartState>(
                builder: (context, cartState) {
                  final cartCubit = context.read<AddToCartCubit>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...toppingsWithIds!.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tp = entry.value;

                        final quantity = cartCubit.getItemQuantity(
                          itemId: itemId,
                          toppingIds: tp.id != null ? [tp.id!] : null,
                        );

                        // If topping price is zero, do not show increase/decrease buttons
                        final isToppingFree = (tp.priceOfQuantity == null || tp.priceOfQuantity == 0 || tp.priceOfQuantity == 0.0);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tp.topping ?? AppStrings.desireToppings.tr(),
                                style: TextStyles.bimini16W400Body,
                              ),
                              isToppingFree
                                  ? SizedBox() // Don't show quantity controls for free toppings
                                  : QuantityControllers(
                                      onIncreaseTap: () {
                                        cartCubit.increaseCartItem(
                                          body: {
                                            "restaurant_id": resturantId,
                                            "item_id": itemId,
                                            if (selectedSizeId != null)
                                              "size": selectedSizeId,
                                            "topping": tp.id,
                                          },
                                          itemIndex: index,
                                          itemId: itemId,
                                          toppingIds: tp.id != null ? [tp.id!] : null,
                                          sizeId: selectedSizeId,
                                        );
                                      },
                                      onDecreaseTap: () {
                                        cartCubit.decreaseCartItem(
                                          body: {
                                            "restaurant_id": resturantId,
                                            "item_id": itemId,
                                            if (selectedSizeId != null)
                                              "size": selectedSizeId,
                                            "topping": tp.id,
                                          },
                                          itemIndex: index,
                                          itemId: itemId,
                                          toppingIds: tp.id != null ? [tp.id!] : null,
                                        );
                                      },
                                      state: state,
                                      themeState: themeState,
                                      showTrach: false,
                                      quantity: quantity,
                                    ),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                },
              )
            else
              BlocBuilder<AddToCartCubit, AddToCartState>(
                builder: (context, cartState) {
                  final cartCubit = context.read<AddToCartCubit>();
                  final quantity = cartCubit.getItemQuantity(itemId: itemId);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.desireToppings.tr(),
                        style: TextStyles.bimini16W400Body,
                      ),
                      QuantityControllers(
                        quantity: quantity,
                        onDecreaseTap: () {
                          cartCubit.decreaseCartItem(
                            body: {
                              "restaurant_id": resturantId,
                              "item_id": itemId,
                            },
                            itemIndex: 0,
                            itemId: itemId,
                          );
                        },
                        state: state,
                        themeState: themeState,
                        showTrach: false,
                      ),
                    ],
                  );
                },
              ),
            SizedBox(height: 5),
            hint == "" || hint?.isEmpty == true
                ? SizedBox()
                : Text("($hint)" ?? "", style: TextStyles.bimini16W400Body),
            verticalSpace(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$totalPrice L.E" ?? '${itemPrice.toInt()} L.E',
                  style: TextStyles.bimini20W700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
