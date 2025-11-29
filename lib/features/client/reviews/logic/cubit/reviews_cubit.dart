import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/reviews/data/repo/review_repo.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewRepo reviewRepo;
  ReviewsCubit(this.reviewRepo) : super(ReviewsState.initial());

  void addReview({required Map<String, dynamic> body}) async {
    emit(ReviewsState.loading());
    try {
      final response = await reviewRepo.addReview(body: body);
      response.when(
        success: (reviewsRes) {
          emit(ReviewsState.success(reviewsRes));
        },
        failure: (error) => emit(ReviewsState.fail(error)),
      );
    } catch (e) {
      emit(ReviewsState.fail(ApiErrorHandler.handle(e)));
    }
  }
}
