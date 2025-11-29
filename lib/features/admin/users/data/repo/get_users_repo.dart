import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/admin/users/data/models/ban_user_response.dart';
import 'package:delveria/features/admin/users/data/models/get_all_users_model.dart';

class GetUsersRepo {
  final ApiServices apiServices;

  GetUsersRepo({required this.apiServices});

  Future<ApiResult<GetAllUsersModel>> getAllUsers() async {
    try {
      final res = await apiServices.getAllUsers({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<BanUserResponse>> banUser({required String userId}) async {
    try {
      final res = await apiServices.banUser({}, userId);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<GetAllUsersModel>> searchUser({
    required String query,
  }) async {
    try {
      final res = await apiServices.searchUser({"search": query});
      return ApiResult.success(res);
    } catch (e) {
      print("🤬 error $e");
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
