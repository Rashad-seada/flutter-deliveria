import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/data/models/notifications_model.dart';

class NotificationRepo {
  final ApiServices apiServices;

  NotificationRepo({required this.apiServices});

  Future<ApiResult<NotificationsModel>> getNotification() async {
    try {
      final res = await apiServices.getNotification({});
      print("Notification Response: ${res.toJson()}");
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult> createNotfication({required Map<String,dynamic> body}) async {
    try {
      final res = await apiServices.createNotification(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
