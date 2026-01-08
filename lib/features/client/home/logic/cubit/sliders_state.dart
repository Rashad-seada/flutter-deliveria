import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'sliders_state.freezed.dart';

@freezed
class SlidersState<T> with _$SlidersState {
  const factory SlidersState.initial() = _Initial;
  const factory SlidersState.loading() = Loading;
  const factory SlidersState.success(T data ) = Success<T>;
  const factory SlidersState.fail(ApiErrorModel error ) = Fail;
  const factory SlidersState.createLoading(int index) = CreateLoading;
  const factory SlidersState.createSuccess(T data  , int index) = CreateSuccess<T>;
  const factory SlidersState.createFail(ApiErrorModel error , int index) = CreateFail;
  const factory SlidersState.deleteLoading(int index) = DeleteLoading;
  const factory SlidersState.deleteSuccess(T data  , int index) = DeleteSuccess<T>;
  const factory SlidersState.deleteFail(ApiErrorModel error , int index) = DeleteFail;
  const factory SlidersState.searchRestuantUserLoading() = SearchRestuantUserLoading;
  const factory SlidersState.searchRestuantUserSuccess(T data  ) = SearchRestuantUserSuccess<T>;
  const factory SlidersState.searchRestuantUserFail(ApiErrorModel error ) = SearchRestuantUserFail;
  const factory SlidersState.searchRestuantItemLoading() = SearchRestuantItemLoading;
  const factory SlidersState.searchRestuantItemSuccess(T data  ) = SearchRestuantItemSuccess<T>;
  const factory SlidersState.searchRestuantItemFail(ApiErrorModel error ) = SearchRestuantItemFail;
}


