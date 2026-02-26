import 'dart:convert';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/features/client/cart/data/models/local_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static removeData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static setData(String key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value);
        break;
      case int:
        await sharedPreferences.setInt(key, value);
        break;
      case bool:
        await sharedPreferences.setBool(key, value);
        break;
      case double:
        await sharedPreferences.setDouble(key, value);
        break;
      default:
        return null;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static getBool(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static getDouble(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static getInt(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
   
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }

  // --- Local Cart Methods (Guest Mode) ---

  /// Get list of LocalCartItems
  static Future<List<LocalCartItem>> getLocalCartItems() async {
    final jsonString = await getString(SharedPrefKeys.guestCart);
    if (jsonString.isEmpty) return [];
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => LocalCartItem.fromJson(e)).toList();
    } catch (e) {
      print("Error decoding local cart: $e");
      return [];
    }
  }

  /// Save new item to local cart
  static Future<void> saveLocalCartItem(LocalCartItem newItem) async {
    final items = await getLocalCartItems();
    // Check if item exists (same IDs, size, toppings) -> Update quantity
    int index = -1;
    for(int i=0; i<items.length; i++) {
        final existing = items[i];
        if(existing.addRequest.itemId == newItem.addRequest.itemId &&
           existing.addRequest.size == newItem.addRequest.size) {
           
           // Compare toppings (IDs)
           final existingToppings = existing.addRequest.toppings.map((e) => e.topping).toSet();
           final newToppings = newItem.addRequest.toppings.map((e) => e.topping).toSet();
           
           if (existingToppings.length == newToppings.length && existingToppings.containsAll(newToppings)) {
             index = i; 
             break; 
           }
        }
    }

    if (index != -1) {
       // Update quantity
       final updatedItem = items[index].copyWith(quantity: items[index].quantity + newItem.quantity);
       items[index] = updatedItem;
    } else {
       items.add(newItem);
    }
    
    await _saveLocalCartList(items);
  }

  /// Update quantity of specific item
  static Future<void> updateLocalCartItemQuantity(int index, int quantity) async {
     final items = await getLocalCartItems();
     if(index >=0 && index < items.length) {
        if(quantity <= 0) {
           items.removeAt(index);
        } else {
           items[index] = items[index].copyWith(quantity: quantity);
        }
        await _saveLocalCartList(items);
     }
  }

  /// Remove item
  static Future<void> removeLocalCartItem(int index) async {
     final items = await getLocalCartItems();
     if(index >=0 && index < items.length) {
        items.removeAt(index);
        await _saveLocalCartList(items);
     }
  }

  /// Clear local cart
  static Future<void> clearLocalCart() async {
    await removeData(SharedPrefKeys.guestCart);
  }

  static Future<void> _saveLocalCartList(List<LocalCartItem> items) async {
    final String jsonString = jsonEncode(items.map((e) => e.toJson()).toList());
    await setData(SharedPrefKeys.guestCart, jsonString);
  }
}
