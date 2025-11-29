import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'favorite_state.freezed.dart';

@freezed
class FavoriteState<T> with _$FavoriteState {
  const factory FavoriteState.initial() = _Initial;
  const factory FavoriteState.addToFavLoading() = AddToFavLoading;
  const factory FavoriteState.addToFavSuccess(T data) = AddToFavSuccess<T>;
  const factory FavoriteState.addToFavFail(ApiErrorModel error) = AddToFavFail;
  const factory FavoriteState.getFavLoading() = GetFavLoading;
  const factory FavoriteState.getFavSuccess(T data) = GetFavSuccess<T>;
  const factory FavoriteState.getFavFail(ApiErrorModel error) = GetFavFail;
  const factory FavoriteState.deleteFavLoading() = DeleteFavLoading;
  const factory FavoriteState.deleteFavSuccess(T data) = DeleteFavSuccess<T>;
  const factory FavoriteState.deleteFavFail(ApiErrorModel error) = DeleteFavFail;
}
