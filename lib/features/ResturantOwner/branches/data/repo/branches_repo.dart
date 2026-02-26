import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/branches/data/models/branch_model.dart';

class BranchesRepo {
  final ApiServices _apiServices;

  BranchesRepo(this._apiServices);

  Future<ApiResult<GetBranchesResponse>> getBranches(String restaurantId) async {
    try {
      final response = await _apiServices.getBranches(restaurantId);
      return ApiResult.success(GetBranchesResponse.fromJson(response));
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> createBranch(
      String restaurantId, Map<String, dynamic> body) async {
    try {
      final response = await _apiServices.createBranch(restaurantId, body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> updateBranch(
      String branchId, Map<String, dynamic> body) async {
    try {
      final response = await _apiServices.updateBranch(branchId, body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> toggleBranchStatus(String branchId) async {
    try {
      final response = await _apiServices.toggleBranchStatus(branchId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> deleteBranch(String branchId) async {
    try {
      final response = await _apiServices.deleteBranch(branchId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
