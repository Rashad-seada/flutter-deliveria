import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_history_response.dart';
import 'package:delveria/features/client/loyalty/data/models/validate_code_response.dart';

class LoyaltyRepo {
  /// Get loyalty dashboard with points, tiers, and rewards
  Future<ApiResult<LoyaltyDashboardResponse>> getDashboard() async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.loyaltyDashboard}",
      );
      return ApiResult.success(LoyaltyDashboardResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error getting loyalty dashboard: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get paginated points history
  Future<ApiResult<LoyaltyHistoryResponse>> getHistory({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.loyaltyHistory}",
        queryParameters: {'page': page, 'limit': limit},
      );
      return ApiResult.success(LoyaltyHistoryResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error getting loyalty history: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Validate a loyalty code before applying
  Future<ApiResult<ValidateCodeResponse>> validateCode(String code) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.loyaltyValidateCode}",
        data: {'code': code},
      );
      return ApiResult.success(ValidateCodeResponse.fromJson(response.data));
    } catch (e) {
      print("🔥 Error validating loyalty code: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get public reward tiers (no auth required)
  Future<ApiResult<List<RewardTier>>> getPublicTiers() async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.loyaltyRewardTiers}",
      );
      final List<dynamic> data = response.data['data'] ?? [];
      final tiers = data.map((e) => RewardTier.fromJson(e)).toList();
      return ApiResult.success(tiers);
    } catch (e) {
      print("🔥 Error getting public tiers: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
