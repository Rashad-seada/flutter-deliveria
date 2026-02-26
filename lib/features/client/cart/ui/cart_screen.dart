import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/widgets/guest_login_dialog.dart';
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
import 'package:geolocator/geolocator.dart';
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
    
    // Check location mismatch on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
       _checkLocationMismatch();
    });
  }

  Future<void> _checkLocationMismatch() async {
     try {
         final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
         if (isGuest) return; 

         final savedLat = await SharedPrefHelper.getDouble(SharedPrefKeys.lat);
         final savedLong = await SharedPrefHelper.getDouble(SharedPrefKeys.long);
         
         debugPrint("Mismatch Check: Saved Lat: $savedLat, Long: $savedLong");

         if (savedLat != null && savedLat != 0 && savedLong != null && savedLong != 0) {
            bool hasPermission = false;
            LocationPermission permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
              if (permission == LocationPermission.denied) {
                 // Permissions are denied
                 debugPrint("Mismatch Check: Permission denied");
              } else {
                 hasPermission = true;
              }
            } else if (permission == LocationPermission.deniedForever) {
               // Permissions are denied forever.
               debugPrint("Mismatch Check: Permission denied forever");
            } else {
               hasPermission = true;
            }
            
            if (hasPermission) {
               final currentPosition = await Geolocator.getCurrentPosition();
               final double distanceInMeters = Geolocator.distanceBetween(
                  savedLat,
                  savedLong,
                  currentPosition.latitude,
                  currentPosition.longitude,
               );
               
               debugPrint("Mismatch Check: Distance: $distanceInMeters meters");
               
               // Threshold: 1000 meters (1km)
               if (distanceInMeters > 1000) {
                  if (context.mounted) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 4,
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              Text(
                                "يبدو انك بعيداً عن عنوان التوصيل الحالي",
                                style: TextStyles.bimini16W700,
                                textAlign: TextAlign.center,
                              ),
                              verticalSpace(8),
                              Text(
                                "يبدو أنك على بُعد حوالي ${distanceInMeters.toInt()} متر من هذا العنوان",
                                style: TextStyles.bimini14W700.copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              verticalSpace(24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDeafult,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, Routes.addressListScreen);
                                  },
                                  child: Text("تعديل العنوان الحالي", style: TextStyles.bimini16W700.copyWith(color: Colors.white)),
                                ),
                              ),
                              verticalSpace(12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDeafult,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, Routes.addAddressScreen);
                                  },
                                  child: Text("اضافة عنوان جديد", style: TextStyles.bimini16W700.copyWith(color: Colors.white)),
                                ),
                              ),
                              verticalSpace(12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: AppColors.primaryDeafult),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("لا شكرا", style: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
               }
            }
         } else {
             debugPrint("Mismatch Check: Saved location is null");
         }
     } catch (e) {
       debugPrint("Location check error: $e");
     }
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
                                        ? () async {
                                           final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
                                           
                                           if (isGuest && context.mounted) {
                                               showGuestLoginDialog(context, message: "Please login to proceed to checkout.");
                                               return;
                                           }
                                           
                                           if (context.mounted) {
                                              context.pushReplacementNamed(
                                                Routes.checkoutScreen,
                                                arguments: finalPrice,
                                              );
                                           }
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
