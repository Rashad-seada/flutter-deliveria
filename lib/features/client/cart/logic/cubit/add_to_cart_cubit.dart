import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:delveria/features/client/cart/data/models/add_to_cart_request.dart';
import 'package:delveria/features/client/cart/data/models/get_cart_response.dart';
import 'package:delveria/features/client/cart/data/repo/cart_repo.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final CartRepo cartRepo;

  AddToCartCubit(this.cartRepo) : super(AddToCartState.initial());

  CartData? cartData;

  Map<String, int> itemQuantities = {};

  void addToCart({required AddToCartRequest addToCart}) async {
    emit(AddToCartState.loading());
    try {
   
      final res = await cartRepo.addToCart(addToCart: addToCart);
      res.when(
        success: (cartRes) {
          if (cartRes.message!.contains("3") ||
              cartRes.message!.contains("٣")) {
            emit(
              AddToCartState.fail(
                ApiErrorModel(success: false, message: cartRes.message ?? ""),
              ),
            );
          }else{
            emit(AddToCartState.success(cartRes));

          }
        },
        failure: (error) => emit(AddToCartState.fail(error)),
      );
    } catch (e) {
      print('AddToCart Error: $e');
      emit(AddToCartState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void getCart() async {
    emit(AddToCartState.getCartLoading());
    try {
      final response = await cartRepo.getCart();
      response.when(
        success: (getCartres) {
          cartData = getCartres.data;
          _initializeQuantitiesFromCartData();
          emit(AddToCartState.getCartSuccess(getCartres));
        },
        failure: (error) => emit(AddToCartState.getCartFail(error)),
      );
    } catch (e) {
      emit(AddToCartState.getCartFail(ApiErrorHandler.handle(e)));
    }
  }

  void _initializeQuantitiesFromCartData() {
    if (cartData?.carts == null) return;

    itemQuantities.clear();

    for (final cart in cartData!.carts!) {
      if (cart.items == null) continue;

      for (final item in cart.items!) {
        final itemId = item.item_details?.id;
        if (itemId == null) continue;

        // Handle size details
        if (item.size_details != null) {
          final sizeDetail = item.size_details;
          String? sizeId;
          int? quantity;

          try {
            sizeId = sizeDetail?.id;
            quantity = sizeDetail?.quantity?.toInt();
          } catch (e) {
            print('Error accessing size details: $e');
          }

          if (sizeId != null && quantity != null && quantity > 0) {
            final sizeKey = _generateItemKey(itemId: itemId, sizeId: sizeId);
            itemQuantities[sizeKey] = quantity;
          }
        }

        // Handle topping details - support both single and multiple toppings
        if (item.topping_details != null) {
          final toppingDetail = item.topping_details;

          // If toppingDetail is a List, handle multiple toppings
          if (toppingDetail is List) {
            for (final topping in toppingDetail ?? []) {
              String? toppingId;
              int? quantity;

              try {
                toppingId = topping?.id;
                quantity = topping?.quantity?.toInt();
              } catch (e) {
                print('Error accessing topping details (list): $e');
              }

              if (toppingId != null && quantity != null && quantity > 0) {
                final toppingKey = _generateItemKey(
                  itemId: itemId,
                  toppingId: toppingId,
                );
                itemQuantities[toppingKey] = quantity;
              }
            }
          }
          // } else {
          //   // Single topping object
          //   String? toppingId;
          //   int? quantity;

          //   try {
          //     toppingId = toppingDetail?.id;
          //     quantity = toppingDetail?.quantity?.toInt();
          //   } catch (e) {
          //     print('Error accessing topping details: $e');
          //   }

          //   if (toppingId != null && quantity != null && quantity > 0) {
          //     final toppingKey = _generateItemKey(
          //       itemId: itemId,
          //       toppingId: toppingId,
          //     );
          //     itemQuantities[toppingKey] = quantity;
          //   }
          // }
        }

        // Handle items without size or topping
        if (item.size_details == null && item.topping_details == null) {
          final baseKey = _generateItemKey(itemId: itemId);
          itemQuantities[baseKey] = 1;
        }
      }
    }

    print('Initialized quantities: $itemQuantities');
  }

  // Updated to handle multiple toppings for key generation
  String _generateItemKey({
    required String itemId,
    String? sizeId,
    String? toppingId,
    List<String>? toppingIds,
  }) {
    String toppingsKey = 'no_topping';

    if (toppingIds != null && toppingIds.isNotEmpty) {
      // Sort to ensure consistent key generation
      final sortedToppings = List<String>.from(toppingIds)..sort();
      toppingsKey = sortedToppings.join(',');
    } else if (toppingId != null) {
      toppingsKey = toppingId;
    }

    return '${itemId}_${sizeId ?? 'no_size'}_$toppingsKey';
  }

  // Updated to support both single and multiple toppings
  int getItemQuantity({
    required String itemId,
    String? sizeId,
    String? toppingId,
    List<String>? toppingIds,
  }) {
    final key = _generateItemKey(
      itemId: itemId,
      sizeId: sizeId,
      toppingId: toppingId,
      toppingIds: toppingIds,
    );
    final quantity = itemQuantities[key] ?? 0;
    print('Getting quantity for key $key: $quantity');
    return quantity;
  }

  void increaseCartItem({
    required Map<String, dynamic> body,
    required int itemIndex,
    required String itemId,
    String? sizeId,
    String? toppingId,
    List<String>? toppingIds,
  }) async {
    final itemKey = _generateItemKey(
      itemId: itemId,
      sizeId: sizeId,
      toppingId: toppingId,
      toppingIds: toppingIds,
    );

    emit(AddToCartState.increaseCartLoading(itemIndex));

    try {
      final response = await cartRepo.increaseItemCart(body: body);
      response.when(
        success: (increaseRes) {
          if (increaseRes.data?.newQuantity != null) {
            itemQuantities[itemKey] = increaseRes.data!.newQuantity!;
          } else {
            itemQuantities[itemKey] = (itemQuantities[itemKey] ?? 0) + 1;
          }

          getCart();

          emit(AddToCartState.increaseCartSuccess(increaseRes, itemIndex));
        },
        failure:
            (error) => emit(AddToCartState.increaseCartFail(error, itemIndex)),
      );
    } catch (e) {
      emit(
        AddToCartState.increaseCartFail(ApiErrorHandler.handle(e), itemIndex),
      );
    }
  }

  void decreaseCartItem({
    required Map<String, dynamic> body,
    required int itemIndex,
    required String itemId,
    String? sizeId,
    String? toppingId,
    List<String>? toppingIds,
  }) async {
    final itemKey = _generateItemKey(
      itemId: itemId,
      sizeId: sizeId,
      toppingId: toppingId,
      toppingIds: toppingIds,
    );

    emit(AddToCartState.decreaseCartLoading(itemIndex));

    try {
      final response = await cartRepo.decreaseItemCart(body: body);
      response.when(
        success: (decreaseRes) {
          if (decreaseRes.data?.newQuantity != null) {
            itemQuantities[itemKey] = decreaseRes.data!.newQuantity!;
            if (decreaseRes.data!.newQuantity! <= 0) {
              itemQuantities.remove(itemKey);
            }
          } else {
            final currentQuantity = itemQuantities[itemKey] ?? 0;
            if (currentQuantity > 1) {
              itemQuantities[itemKey] = currentQuantity - 1;
            } else {
              itemQuantities.remove(itemKey);
            }
          }

          getCart();

          emit(AddToCartState.decreaseCartSuccess(decreaseRes, itemIndex));
        },
        failure:
            (error) => emit(AddToCartState.decreaseCartFail(error, itemIndex)),
      );
    } catch (e) {
      emit(
        AddToCartState.decreaseCartFail(ApiErrorHandler.handle(e), itemIndex),
      );
    }
  }

  void removeCart({required Map<String, dynamic> body}) async {
    emit(AddToCartState.removeCartLoading());
    try {
      final response = await cartRepo.removeCart(body: body);
      response.when(
        success: (removeCartRes) {
          final itemId = body['item_id'];
          final sizeId = body['size'];
          final toppingId = body['topping'];

          if (itemId != null) {
            final itemKey = _generateItemKey(
              itemId: itemId,
              sizeId: sizeId,
              toppingId: toppingId,
            );
            itemQuantities.remove(itemKey);
          }

          getCart();

          emit(AddToCartState.removeCartSuccess(removeCartRes));
        },
        failure: (error) => emit(AddToCartState.removeCartFail(error)),
      );
    } catch (e) {
      emit(AddToCartState.removeCartFail(ApiErrorHandler.handle(e)));
    }
  }

  void addOrder({required Map<String, dynamic> body}) async {
    emit(AddToCartState.addOrderLoading());
    try {
      final response = await cartRepo.addOrder(body: body);
      response.when(
        success: (removeCartRes) {
          emit(AddToCartState.addOrderSuccess(removeCartRes));
        },
        failure: (error) => emit(AddToCartState.addOrderFail(error)),
      );
    } catch (e) {
      emit(AddToCartState.addOrderFail(ApiErrorHandler.handle(e)));
    }
  }

  void refreshQuantities() {
    _initializeQuantitiesFromCartData();
  }
}
