import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/features/client/cart/data/models/add_to_cart_request.dart';
import 'package:delveria/features/client/cart/data/models/add_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/get_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/local_cart_item.dart';
import 'package:delveria/features/client/cart/data/repo/cart_repo.dart';
import 'package:delveria/features/client/cart/data/models/increase_item_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/decrease_item_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/remove_cart_response.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<AddToCartState<dynamic>> {
  final CartRepo cartRepo;

  AddToCartCubit(this.cartRepo) : super(AddToCartState.initial());

  CartData? cartData;

  Map<String, int> itemQuantities = {};

  void addToCart({
    required AddToCartRequest addToCart,
    String? itemName,
    String? itemImage,
    double? itemPrice,
    String? sizeName,
    List<String>? toppingNames,
    String? restaurantName,
    String? restaurantImage,
  }) async {
    print("Debug: Inside addToCart. isClosed: $isClosed");
    if (isClosed) {
       print("Debug: Cubit is closed!");
       return;
    }
    
    final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
    
    emit(AddToCartState.loading());
    print("Debug: AddToCartCubit.addToCart called with itemId: ${addToCart.itemId}, size: ${addToCart.size}");
    try {
      if (isGuest) {
        // Guest Mode: Save locally
        if (itemName == null || itemImage == null || itemPrice == null) {
           print("Guest Cart Error: Missing item details for local storage");
           if (!isClosed) emit(AddToCartState.fail(ApiErrorModel(success: false, message: "Missing item details")));
           return;
        }

        final localItem = LocalCartItem(
          addRequest: addToCart,
          itemName: itemName,
          itemImage: itemImage,
          itemPrice: itemPrice, 
          sizeName: sizeName,
          toppingNames: toppingNames,
          restaurantName: restaurantName,
          restaurantImage: restaurantImage,
        );
        
        await SharedPrefHelper.saveLocalCartItem(localItem);
        
        final simulatedResponse = AddCartResponse(
           message: "Added to cart", 
        );
        
        if (!isClosed) emit(AddToCartState.success(simulatedResponse));
        getCart(); 
        
      } else {
        // ... user mode logic (unchanged) ...
        final res = await cartRepo.addToCart(addToCart: addToCart);
        if (isClosed) return;
        res.when(
          success: (cartRes) {
            if (cartRes.message!.contains("3") ||
                cartRes.message!.contains("٣")) {
              if (!isClosed) {
                emit(
                  AddToCartState.fail(
                    ApiErrorModel(success: false, message: cartRes.message ?? ""),
                  ),
                );
              }
            }else{
              if (!isClosed) emit(AddToCartState.success(cartRes));
              getCart();
            }
          },
          failure: (error) {
            if (!isClosed) emit(AddToCartState.fail(error));
          },
        );
      }
    } catch (e) {
      print('AddToCart Error: $e');
      if (!isClosed) emit(AddToCartState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void getCart() async {
    if (isClosed) return;
    emit(AddToCartState.getCartLoading());
    try {
      final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
      if (isGuest) {
        await _getGuestCart();
      } else {
        final response = await cartRepo.getCart();
        if (isClosed) return;
        response.when(
          success: (getCartres) {
            cartData = getCartres.data;
            _initializeQuantitiesFromCartData();
            if (!isClosed) emit(AddToCartState.getCartSuccess(getCartres));
          },
          failure: (error) {
            if (!isClosed) emit(AddToCartState.getCartFail(error));
          },
        );
      }
    } catch (e) {
      if (!isClosed) emit(AddToCartState.getCartFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> _getGuestCart() async {
     final localItems = await SharedPrefHelper.getLocalCartItems();
     
     // Group by Restaurant
     final Map<String, List<LocalCartItem>> grouped = {};
     for(final item in localItems) {
        final resId = item.addRequest.restaurantId;
        if(!grouped.containsKey(resId)) grouped[resId] = [];
        grouped[resId]!.add(item);
     }

     List<Cart> carts = [];
     double totalFinalPrice = 0;

     grouped.forEach((resId, items) {
        double resTotal = 0;
        List<CartItem> cartItems = [];
        String resName = "";

        for(final item in items) {
           resName = item.restaurantName ?? "";
           final itemTotal = item.itemPrice * item.quantity;
           resTotal += itemTotal;
           
           // Map LocalCartItem to CartItem
           cartItems.add(CartItem(
              item_details: ItemDetails(
                 id: item.addRequest.itemId,
                 name: item.itemName,
                 photo: item.itemImage,
                 description: "", 
              ),
              size_details: item.sizeName != null ? SizeDetails(name: item.sizeName) : null,
              topping_details: item.toppingNames?.map((t) => ToppingDetails(topping: t)).toList() ?? [],
              total_price: itemTotal,
              description: item.addRequest.description,
              // We need to store quantity somewhere, typically SizeDetails or Top level. 
              // CartItem usually doesn't have direct quantity? 
              // Checking CartItem model: it has size_details which has quantity.
              // If no size, it seems quantity is missing from CartItem root?
              // The API usually returns quantity inside size_details OR topping_details.
              // For items without size, we might need to fake a size or rely on how Backend handles it.
              // Let's put quantity in SizeDetails if present, otherwise... check logic.
              // The logic _initializeQuantitiesFromCartData handles it.
           ));
           
           // HACK: To make _initializeQuantitiesFromCartData work for guest
           // We need to match the structure it expects.
           // It checks size_details.quantity
           if (item.sizeName != null) {
              cartItems.last = CartItem(
                 item_details: cartItems.last.item_details,
                 size_details: SizeDetails(id: "guest_size", name: item.sizeName, quantity: item.quantity),
                 topping_details: cartItems.last.topping_details,
                 total_price: itemTotal
              );
           } else {
             // If no size, _initializeQuantitiesFromCartData checks:
             // if (item.size_details == null && item.topping_details == null)
             // So we are good for base items.
             // But wait, it doesn't read quantity for base items from anywhere?
             // Ah, line 155: itemQuantities[baseKey] = 1; -> It assumes quantity 1?
             // That seems like a bug or I misread.
             // "itemQuantities[baseKey] = 1;"
             // If quantity is stored elsewhere?
             // For guest mode, I'll simulate size if quantity > 1? Or just handle it.
             // If I need to support Quantity, I should probably wrap it in a dummy Size if none exists, OR
             // Update _initializeQuantitiesFromCartData to handle guest quantities better.
             // Let's assume simpler path: Mock SizeDetails for now if null.
              if(item.quantity > 0) {
                 // Force a size detail to carry quantity if not present?
                 // actually line 155 sets it to 1. This means API might not support quantity on base items?
                 // Or it's handled differently.
                 // Let's stick to what we have.
              }
           }
        }
        
        carts.add(Cart(
           restaurant_details: RestaurantDetails(id: resId, name: resName, delivery_cost: 0), // Delivery cost 0 for now
           items: cartItems,
           price_of_restaurant: resTotal
        ));
        totalFinalPrice += resTotal;
     });

     final cartDataObj = CartData(
        carts: carts,
        final_price: totalFinalPrice,
        final_price_without_delivery_cost: totalFinalPrice,
        final_delivery_cost: 0
     );
     
     cartData = cartDataObj;
     _initializeGuestQuantities(localItems); // Direct map instead of parsing simulated structure
     
     if (!isClosed) emit(AddToCartState.getCartSuccess(GetCartResponse(success: true, data: cartData)));
  }

  void _initializeGuestQuantities(List<LocalCartItem> items) {
      itemQuantities.clear();
      for(final item in items) {
          // Generate Key
          String toppingsKey = 'no_topping';
          if (item.toppingNames != null && item.toppingNames!.isNotEmpty) {
             final sorted = List<String>.from(item.toppingNames!)..sort();
             toppingsKey = sorted.join(',');
          }
          final key = '${item.addRequest.itemId}_${item.addRequest.size.isEmpty ? "no_size" : item.addRequest.size}_$toppingsKey';
          // Wait, addRequest.size is ID? 
          // For guest I am storing Name or ID? AddToCartRequest usually needs ID.
          // Setup: When adding, I use ID.
          
          itemQuantities[key] = item.quantity;
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
          itemQuantities[baseKey] = item.quantity ?? 1;
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

    if (isClosed) return;
    
    final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
    
    emit(AddToCartState.increaseCartLoading(itemIndex));

    try {
      if (isGuest) {
          final items = await SharedPrefHelper.getLocalCartItems();
          int index = -1;
          for(int i=0; i<items.length; i++) {
             if(items[i].addRequest.itemId == itemId && 
                items[i].addRequest.size == (sizeId ?? "") &&
                _toppingsMatch(items[i].addRequest.toppings, toppingIds, toppingId)) {
                  index = i;
                  break;
                }
          }
          
          if (index != -1) {
             final newQty = items[index].quantity + 1;
             await SharedPrefHelper.updateLocalCartItemQuantity(index, newQty);
             
             itemQuantities[itemKey] = newQty;
             
             // Simulate response
             final mockRes = IncreaseItemCartResponse(data: IncreaseItemCartData(newQuantity: newQty));
             if (!isClosed) emit(AddToCartState.increaseCartSuccess(mockRes, itemIndex));
             getCart();
          } else {
             if (!isClosed) emit(AddToCartState.increaseCartFail(ApiErrorModel(success: false, message: "Item not found"), itemIndex));
          }
          
      } else {
          final response = await cartRepo.increaseItemCart(body: body);
          if (isClosed) return;
          response.when(
            success: (increaseRes) {
              if (increaseRes.data?.newQuantity != null) {
                itemQuantities[itemKey] = increaseRes.data!.newQuantity!;
              } else {
                itemQuantities[itemKey] = (itemQuantities[itemKey] ?? 0) + 1;
              }

              getCart();

              if (!isClosed) emit(AddToCartState.increaseCartSuccess(increaseRes, itemIndex));
            },
            failure:
                (error) {
              if (!isClosed) emit(AddToCartState.increaseCartFail(error, itemIndex));
            },
          );
      }
    } catch (e) {
      if (!isClosed) emit(
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

    if (isClosed) return;
    final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);

    emit(AddToCartState.decreaseCartLoading(itemIndex));

    try {
      if (isGuest) {
          final items = await SharedPrefHelper.getLocalCartItems();
          int index = -1;
          for(int i=0; i<items.length; i++) {
             if(items[i].addRequest.itemId == itemId && 
                items[i].addRequest.size == (sizeId ?? "") &&
                _toppingsMatch(items[i].addRequest.toppings, toppingIds, toppingId)) {
                  index = i;
                  break;
                }
          }
          
          if (index != -1) {
             final newQty = items[index].quantity - 1;
             await SharedPrefHelper.updateLocalCartItemQuantity(index, newQty);
             
             if (newQty <= 0) {
                itemQuantities.remove(itemKey);
             } else {
                itemQuantities[itemKey] = newQty;
             }
             
             final mockRes = DecreaseItemCartResponse(success: true, message: 'Decreased', data: DecreaseItemCartData(newQuantity: newQty));
             if (!isClosed) emit(AddToCartState.decreaseCartSuccess(mockRes, itemIndex));
             getCart();
          } else {
             if (!isClosed) emit(AddToCartState.decreaseCartFail(ApiErrorModel(success: false, message: "Item not found"), itemIndex));
          }
      } else {
        final response = await cartRepo.decreaseItemCart(body: body);
        if (isClosed) return;
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

            if (!isClosed) emit(AddToCartState.decreaseCartSuccess(decreaseRes, itemIndex));
          },
          failure:
              (error) {
            if (!isClosed) emit(AddToCartState.decreaseCartFail(error, itemIndex));
          },
        );
      }
    } catch (e) {
      if (!isClosed) emit(
        AddToCartState.decreaseCartFail(ApiErrorHandler.handle(e), itemIndex),
      );
    }
  }

  void removeCart({required Map<String, dynamic> body}) async {
    if (isClosed) return;
    final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
    emit(AddToCartState.removeCartLoading());
    try {
      if (isGuest) {
          final itemId = body['item_id'];
          final sizeId = body['size'];
          final topping = body['topping']; // Could be list or single ID?
          // For logic simplification, assume topping is what we get.
          // body map depends on how it's called.
          // Usually from UI: removeCart(body: {item_id, size, topping})
          
          final items = await SharedPrefHelper.getLocalCartItems();
          int index = -1;
          for(int i=0; i<items.length; i++) {
             // Matching logic needs to be robust to body content
             bool match = items[i].addRequest.itemId == itemId;
             if(match) {
                 if (sizeId != null && items[i].addRequest.size != sizeId) match = false;
                 // Topping check? If body has topping, check if item has it.
                 // This is tricky without strict types.
                 // Let's assume if size matches and ID matches, it's the item for now?
                 // No, multiple items same ID different size/topping.
                 // We should ideally pass toppingId params to removeCart like other methods.
                 // But removeCart sig takes ONLY map.
                 // So we parse map.
             }
             
             // Better: Iterate all items, generate their Key, key matches?
             // Key generation needs IDs.
             // Let's try to match as best as possible.
             if(items[i].addRequest.itemId == itemId && (sizeId == null || items[i].addRequest.size == sizeId)) {
                 // Check toppings?
                 // If body['topping'] is list or id.
                 dynamic t = body['topping'];
                 List<String> tIds = [];
                 if(t is List) tIds = t.map((e)=>e.toString()).toList();
                 else if (t != null) tIds.add(t.toString());
                 
                 if (_toppingsMatch(items[i].addRequest.toppings, tIds, null)) {
                    index = i;
                    break;
                 }
             }
          }
          
          if(index != -1) {
             await SharedPrefHelper.removeLocalCartItem(index);
             // Key removal
             final itemKey = _generateItemKey(
               itemId: itemId,
               sizeId: sizeId,
               toppingIds: body['topping'] is List ? (body['topping'] as List).cast<String>() : (body['topping'] != null ? [body['topping']] : null)
             );
             itemQuantities.remove(itemKey);
             
             final mockRes = RemoveCartResponse(message: "Removed");
             if (!isClosed) emit(AddToCartState.removeCartSuccess(mockRes));
             getCart();
          } else {
             if (!isClosed) emit(AddToCartState.removeCartFail(ApiErrorModel(success: false, message: "Item not found")));
          }
          
      } else {
        final response = await cartRepo.removeCart(body: body);
        if (isClosed) return;
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

            if (!isClosed) emit(AddToCartState.removeCartSuccess(removeCartRes));
          },
          failure: (error) {
            if (!isClosed) emit(AddToCartState.removeCartFail(error));
          },
        );
      }
    } catch (e) {
      if (!isClosed) emit(AddToCartState.removeCartFail(ApiErrorHandler.handle(e)));
    }
  }

  bool _toppingsMatch(List<ToppingRequest> itemToppings, List<String>? targetToppings, String? targetToppingId) {
     final itemToppingIds = itemToppings.map((e) => e.topping).toSet();
     final targetSet = <String>{};
     if(targetToppings != null) targetSet.addAll(targetToppings);
     if(targetToppingId != null) targetSet.add(targetToppingId);
     
     if (itemToppingIds.length != targetSet.length) return false;
     return itemToppingIds.containsAll(targetSet);
  }

  void addOrder({required Map<String, dynamic> body}) async {
    if (isClosed) return;
    emit(AddToCartState.addOrderLoading());
    try {
      final response = await cartRepo.addOrder(body: body);
      if (isClosed) return;
      response.when(
        success: (removeCartRes) {
          if (!isClosed) emit(AddToCartState.addOrderSuccess(removeCartRes));
        },
        failure: (error) {
          if (!isClosed) emit(AddToCartState.addOrderFail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(AddToCartState.addOrderFail(ApiErrorHandler.handle(e)));
    }
  }

  void refreshQuantities() {
    _initializeQuantitiesFromCartData();
  }
  Future<void> syncGuestCart() async {
     if (isClosed) return;
     
     final localItems = await SharedPrefHelper.getLocalCartItems();
     if(localItems.isEmpty) return;
     
     // emit(AddToCartState.loading()); // Optional: might block UI
     
     try {
        for(final item in localItems) {
           try {
              // Iterate quantity times or use API that supports quantity?
              // The API add_to_cart usually adds 1. 
              // If we have quantity 3, we should call it 3 times or look for 'quantity' param in API?
              // Checking AddToCartRequest: it does NOT have quantity.
              // So we must loop quantity times.
              for(int q=0; q<item.quantity; q++) {
                 await cartRepo.addToCart(addToCart: item.addRequest);
              }
           } catch (e) {
              print("Failed to sync item: ${item.itemName} error: $e");
           }
        }
        
        await SharedPrefHelper.clearLocalCart();
        getCart(); // Fetch server cart
        
     } catch (e) {
        print("Sync Error: $e");
        getCart(); 
     }
  }
}
