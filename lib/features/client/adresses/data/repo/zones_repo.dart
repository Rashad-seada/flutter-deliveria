import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/client/adresses/data/models/delivery_zone.dart';
import 'package:delveria/features/client/adresses/data/models/zone_check_response.dart';
import 'package:delveria/features/client/adresses/data/models/zones_response.dart';

class ZonesRepo {
  /// Get all active delivery zones for map visualization
  Future<ApiResult<GetZonesResponse>> getAllZones() async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.zonesAllLink}",
      );
      final res = GetZonesResponse.fromJson(response.data);
      return ApiResult.success(res);
    } catch (e) {
      print("🔥 Error getting zones: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Check if a location is within a delivery zone
  Future<ApiResult<ZoneCheckResult>> checkLocation({
    required double lat,
    required double lng,
  }) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.zonesCheckLink}",
        data: {
          'latitude': lat,
          'longitude': lng,
        },
      );
      final res = ZoneCheckResult.fromJson(response.data);
      return ApiResult.success(res);
    } catch (e) {
      print("🔥 Error checking zone: $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
