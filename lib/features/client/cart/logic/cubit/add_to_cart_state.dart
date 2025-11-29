import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_cart_state.freezed.dart';

@freezed
class AddToCartState<T> with _$AddToCartState {
  const factory AddToCartState.initial() = _Initial;
  const factory AddToCartState.loading() = Loading;
  const factory AddToCartState.success(T data) = Success<T>;
  const factory AddToCartState.fail(ApiErrorModel error) = Fail;
  const factory AddToCartState.getCartLoading() = GetCartLoading;
  const factory AddToCartState.getCartSuccess(T data) = GetCartSuccess<T>;
  const factory AddToCartState.getCartFail(ApiErrorModel error) = GetCartFail;
  const factory AddToCartState.increaseCartLoading(int index) =
      IncreaseCartLoading<T>;
  const factory AddToCartState.increaseCartSuccess(T data, int index) =
      IncreaseCartSuccess<T>;
  const factory AddToCartState.increaseCartFail(
    ApiErrorModel error,
    int index,
  ) = IncreaseCartFail<T>;
  const factory AddToCartState.decreaseCartLoading(int index) =
      DecreaseCartLoading<T>;
  const factory AddToCartState.decreaseCartSuccess(T data, int index) =
      DecreaseCartSuccess<T>;
  const factory AddToCartState.decreaseCartFail(
    ApiErrorModel error,
    int index,
  ) = DecreaseCartFail<T>;
  const factory AddToCartState.removeCartLoading() = RemoveCartLoading<T>;
  const factory AddToCartState.removeCartSuccess(T data) = RemoveCartSuccess<T>;
  const factory AddToCartState.removeCartFail(ApiErrorModel error) =
      RemoveCartFail<T>;
  const factory AddToCartState.addOrderLoading() = AddOrderLoading;
  const factory AddToCartState.addOrderSuccess(T data) = AddOrderSuccess<T>;
  const factory AddToCartState.addOrderFail(ApiErrorModel error) =
      AddOrderFail;
}
