import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'reviews_state.freezed.dart';

@freezed
class ReviewsState<T> with _$ReviewsState {
  const factory ReviewsState.initial() = _Initial;
  const factory ReviewsState.loading() = Loading;
  const factory ReviewsState.success(T data) = Success<T>;
  const factory ReviewsState.fail(ApiErrorModel error) = Fail;
}
