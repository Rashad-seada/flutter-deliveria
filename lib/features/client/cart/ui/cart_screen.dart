import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/cart/ui/widgets/cart_item_meta.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<bool> _onWillPop() async {
    // This will close the app when back is pressed
    await SystemNavigator.pop();
    return false; // Prevent further popping
  }

  // i made this to handle app store payment cash
  bool isOnline = false;

  @override
  void initState() {
    super.initState();
    _loadOnlineGuest();
  }

  Future<void> _loadOnlineGuest() async {
    final value = await SharedPrefHelper.getBool(SharedPrefKeys.onlineGuest);
    setState(() {
      isOnline = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: ArrowBackAppBarWithTitle(
            dontShowArrow: true,
            canPop: false,
            showTitle: true,
            title: AppStrings.myCart.tr(),
            titleStyle: TextStyles.bimini20W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
        ),
        body:
            isOnline
                ? Center(
                  child: Text(
                    "Your Cart is empty ",
                    style: TextStyles.bimini20W700,
                  ),
                )
                : BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return BlocBuilder<AddToCartCubit, AddToCartState>(
                      builder: (context, state) {
                        final cubit = context.read<AddToCartCubit>();
                        final carts = cubit.cartData?.carts;
                        final hasCarts = carts != null && carts.isNotEmpty;
                        final allItems = <CartItemMeta>[];
                        if (hasCarts) {
                          for (
                            int cartIndex = 0;
                            cartIndex < carts.length;
                            cartIndex++
                          ) {
                            final cart = carts[cartIndex];
                            final items = cart.items;
                            if (items != null && items.isNotEmpty) {
                              for (
                                int itemIndex = 0;
                                itemIndex < items.length;
                                itemIndex++
                              ) {
                                allItems.add(
                                  CartItemMeta(
                                    cart: cart,
                                    cartData: cubit.cartData!,
                                    cartIndex: cartIndex,
                                    item: items[itemIndex],
                                    itemIndex: itemIndex,
                                    themeState: themeState,
                                  ),
                                );
                              }
                            }
                          }
                        }
                        // Calculate the final price for checkout
                        int finalPrice = 0;
                        if (cubit.cartData != null &&
                            cubit.cartData!.final_price != null) {
                          finalPrice = cubit.cartData!.final_price!.toInt();
                        } else if (cubit.cartData != null &&
                            cubit.cartData!.final_price != null) {
                          finalPrice = cubit.cartData!.final_price!.toInt();
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              if (hasCarts && allItems.isNotEmpty)
                                ...List.generate(allItems.length, (index) {
                                  final meta = allItems[index];
                                  return CartItemContainer(
                                    themeState: meta.themeState,
                                    cartData: meta.cartData,
                                    cart: meta.cart,
                                    item: meta.item,
                                  );
                                })
                              else
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Center(
                                    child: Text(
                                      AppStrings.yourCartIsEmpty.tr(),
                                      style: TextStyles.bimini20W700,
                                    ),
                                  ),
                                ),
                              verticalSpace(120),
                              AppButton(
                                stateOfTheme: themeState,
                                title: AppStrings.processToCheckOut.tr(),
                                onPressed:
                                    hasCarts && allItems.isNotEmpty
                                        ? () {
                                          context.pushReplacementNamed(
                                            Routes.checkoutScreen,
                                            arguments: finalPrice,
                                          );
                                        }
                                        : () {
                                          showWarningSnackBar(
                                            context,
                                            AppStrings.yourCartIsEmpty.tr(),
                                          );
                                        },
                              ),
                              verticalSpace(40),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
