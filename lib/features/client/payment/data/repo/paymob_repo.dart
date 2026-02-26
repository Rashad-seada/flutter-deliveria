import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:flutter/material.dart';

class PaymobRepo {
  final ApiServices apiServices;

  PaymobRepo({required this.apiServices});

  Future<ApiResult<String>> getPaymobToken() async {
    try {
      final res = await apiServices.getPaymobToken({
        "api_key": ApiConstants.apiKey,
      });
      return ApiResult.success(res.token ?? '');
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<int>> createPaymobOrder({
    required String token,
    required double amount,
    required String currency,
    Map<String, dynamic>? items,
  }) async {
    try {
      final res = await apiServices.createPaymobOrder({
        "auth_token": token,
        "delivery_needed": false,
        "amount_cents": (amount * 100).toInt().toString(),
        "currency": currency,
        "items": items ?? [],
      });
      return ApiResult.success(res.orderId ?? 0);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> getPaymentKey({
    required String token,
    required int orderId,
    required double amount,
    required String currency,
    Map<String, dynamic>? billingData,
  }) async {
    try {
      final res = await apiServices.getPaymentKey({
        "auth_token": token,
        "amount_cents": (amount * 100).toInt().toString(),
        "expiration": 3600,
        "order_id": orderId.toString(),
        "billing_data":
            billingData ??
            {
              "apartment": "NA",
              "email": "test@example.com",
              "floor": "NA",
              "first_name": "John",
              "street": "NA",
              "building": "NA",
              "phone_number": "+201234567890",
              "shipping_method": "NA",
              "postal_code": "NA",
              "city": "NA",
              "country": "EG",
              "last_name": "Doe",
              "state": "NA",
            },
        "currency": currency,
        "integration_id": ApiConstants.integrationId,
      });
      return ApiResult.success(res.paymentKey ?? '');
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // Simple version that just returns the payment key
  // No callback handling - that should be done in the UI layer
  Future<ApiResult<String>> getPaymentKeyForUi({
    required double amount,
    required String currency,
    Map<String, dynamic>? items,
    Map<String, dynamic>? billingData,
    VoidCallback?
    onPaymentApproved, // Accept the callback but don't use it here
  }) async {
    try {
      final tokenResult = await getPaymobToken();
      if (tokenResult is Failure) {
        return ApiResult.failure((tokenResult as Failure).message);
      }
      final token = (tokenResult as Success<String>).data;

      final orderResult = await createPaymobOrder(
        token: token,
        amount: amount,
        currency: currency,
        items: items,
      );
      if (orderResult is Failure) {
        return ApiResult.failure((orderResult as Failure).message);
      }
      final orderId = (orderResult as Success<int>).data;

      final paymentKeyResult = await getPaymentKey(
        token: token,
        orderId: orderId,
        amount: amount,
        currency: currency,
        billingData: billingData,
      );

      // Just return the payment key - callback handling is done in UI
      return paymentKeyResult;
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }


}
