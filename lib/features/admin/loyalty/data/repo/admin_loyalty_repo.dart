import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/admin/loyalty/data/models/admin_loyalty_models.dart';

class AdminLoyaltyRepo {
  /// Get all reward tiers (admin)
  Future<ApiResult<AdminRewardTiersResponse>> getAllTiers() async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.adminRewardTiers}",
      );
      return ApiResult.success(AdminRewardTiersResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error getting admin tiers: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Create a new reward tier
  Future<ApiResult<LoyaltySuccessResponse>> createTier({
    required String name,
    required int pointsRequired,
    required num discountValue,
    required String discountType,
    num? maxDiscount,
    String? description,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.adminRewardTiers}",
        data: {
          'name': name,
          'pointsRequired': pointsRequired,
          'discountValue': discountValue,
          'discountType': discountType,
          if (maxDiscount != null) 'maxDiscount': maxDiscount,
          if (description != null) 'description': description,
        },
      );
      return ApiResult.success(LoyaltySuccessResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error creating tier: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Update an existing reward tier
  Future<ApiResult<LoyaltySuccessResponse>> updateTier({
    required String tierId,
    String? name,
    int? pointsRequired,
    num? discountValue,
    String? discountType,
    num? maxDiscount,
    String? description,
    bool? isActive,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (pointsRequired != null) body['pointsRequired'] = pointsRequired;
      if (discountValue != null) body['discountValue'] = discountValue;
      if (discountType != null) body['discountType'] = discountType;
      if (maxDiscount != null) body['maxDiscount'] = maxDiscount;
      if (description != null) body['description'] = description;
      if (isActive != null) body['isActive'] = isActive;

      final response = await dio.put(
        "${ApiConstants.baseUrl}${ApiConstants.adminRewardTiers}/$tierId",
        data: body,
      );
      return ApiResult.success(LoyaltySuccessResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error updating tier: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Delete a reward tier
  Future<ApiResult<LoyaltySuccessResponse>> deleteTier(String tierId) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.delete(
        "${ApiConstants.baseUrl}${ApiConstants.adminRewardTiers}/$tierId",
      );
      return ApiResult.success(LoyaltySuccessResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error deleting tier: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get all users with loyalty points
  Future<ApiResult<AdminLoyaltyUsersResponse>> getUsersWithPoints({
    int page = 1,
    int limit = 20,
    String? searchQuery,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['search'] = searchQuery;
      }

      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.adminLoyaltyUsers}",
        queryParameters: queryParams,
      );

      // Handle case where data is a Map (pagination) instead of List
      var responseData = response.data;
      if (responseData['data'] is Map) {
        final dataMap = responseData['data'] as Map;
        print("🔍 Raw Data Map Keys: ${dataMap.keys}");
        // Check for common pagination keys
        if (dataMap.containsKey('users')) {
          responseData['data'] = dataMap['users'];
        } else if (dataMap.containsKey('docs')) {
          responseData['data'] = dataMap['docs'];
        } else if (dataMap.containsKey('data')) {
           responseData['data'] = dataMap['data'];
        }
      }
      
      print("🔍 Sample User Data (First 1): ${responseData['data'] is List && (responseData['data'] as List).isNotEmpty ? (responseData['data'] as List).first : 'Empty or not a list'}");

      return ApiResult.success(AdminLoyaltyUsersResponse.fromJson(responseData));
    } catch (e) {
      print("🔥 Error getting users with points: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get a specific user's loyalty details
  Future<ApiResult<Map<String, dynamic>>> getUserDetails(String userId) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.adminLoyaltyUsers}/$userId",
      );
      return ApiResult.success(response.data);
    } catch (e) {
      print("🔥 Error getting user details: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Adjust user points (add or remove)
  Future<ApiResult<LoyaltySuccessResponse>> adjustPoints({
    required String userId,
    required int points,
    String? reason,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final url = "${ApiConstants.baseUrl}${ApiConstants.adminLoyaltyAdjust}";
      final body = {
        'userId': userId,
        'points': points,
        if (reason != null) 'description': reason,
      };

      print("🚀 Adjusting Points Request:");
      print("URL: $url");
      print("Body: $body");

      final response = await dio.post(
        url,
        data: body,
      );

      print("✅ Adjust Points Response:");
      print("Status Code: ${response.statusCode}");
      print("Data: ${response.data}");

      return ApiResult.success(LoyaltySuccessResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error adjusting points: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
