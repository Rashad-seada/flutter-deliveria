import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/reviews/data/models/add_review_response.dart';

class ReviewRepo {
  final ApiServices apiServices;

  ReviewRepo({required this.apiServices});
  Future<ApiResult<AddReviewResponse>> addReview({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await apiServices.addReview(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
