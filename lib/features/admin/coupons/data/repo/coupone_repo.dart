import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_request.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_response.dart';
import 'package:delveria/features/admin/coupons/data/models/get_all_coupon_response.dart';
import 'package:delveria/features/admin/users/data/models/ban_user_response.dart';

class CouponeRepo {
  final ApiServices apiServices;

  CouponeRepo({required this.apiServices});

  Future<ApiResult<CouponeResponse>> creatCoupone({
    required CouponeRequest request,
  }) async {
    try {
      final response = await apiServices.creatCoupone(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<CouponeResponse>> checkCoupone({
    required String code,
  }) async {
    try {
      final response = await apiServices.checkCoupone(code, {});
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<GetAllCouponesResponse>> getCoupons() async {
    try {
      final response = await apiServices.getCoupons({});
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
    Future<ApiResult<BanUserResponse>> changeEnableCoupon({required String couponId}) async {
    try {
      final res = await apiServices.changeEnableCoupon({}, couponId);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<CouponeResponse>> updateCoupon({
    required String id,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final response = await apiServices.updateCoupon(id, updates);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> deleteCoupon({required String id}) async {
    try {
      await apiServices.deleteCoupon(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<bool>> toggleCouponStatus({required String id}) async {
    try {
      final response = await apiServices.toggleCouponStatus(id);
      return ApiResult.success(response['is_active']);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
