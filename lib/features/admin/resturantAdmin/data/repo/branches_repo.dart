import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/branch_model.dart';
import 'package:dio/dio.dart';

class BranchesRepo {
  final Dio _dio = DioFactory.getDio();

  Future<String> _getToken() async {
    return 'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}';
  }

  /// Get all branches of a restaurant
  Future<ApiResult<BranchesResponse>> getBranches({
    required String restaurantId,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getBranchesLink}/$restaurantId/branches',
        options: Options(headers: {'Authorization': token}),
      );
      return ApiResult.success(BranchesResponse.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Create a new branch
  Future<ApiResult<Map<String, dynamic>>> createBranch({
    required String restaurantId,
    required Map<String, dynamic> branchData,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.getBranchesLink}/$restaurantId/branches',
        data: branchData,
        options: Options(headers: {'Authorization': token}),
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Get single branch details
  Future<ApiResult<BranchModel>> getBranchDetails({
    required String branchId,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.branchLink}/$branchId',
        options: Options(headers: {'Authorization': token}),
      );
      final data = response.data['data'] ?? response.data;
      return ApiResult.success(BranchModel.fromJson(data));
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Update branch
  Future<ApiResult<Map<String, dynamic>>> updateBranch({
    required String branchId,
    required Map<String, dynamic> branchData,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.put(
        '${ApiConstants.baseUrl}${ApiConstants.branchLink}/$branchId',
        data: branchData,
        options: Options(headers: {'Authorization': token}),
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Delete branch (soft delete)
  Future<ApiResult<Map<String, dynamic>>> deleteBranch({
    required String branchId,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.delete(
        '${ApiConstants.baseUrl}${ApiConstants.branchLink}/$branchId',
        options: Options(headers: {'Authorization': token}),
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  /// Toggle branch (pause/resume)
  Future<ApiResult<Map<String, dynamic>>> toggleBranch({
    required String branchId,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.patch(
        '${ApiConstants.baseUrl}${ApiConstants.toggleBranchLink}/$branchId/toggle',
        options: Options(headers: {'Authorization': token}),
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
