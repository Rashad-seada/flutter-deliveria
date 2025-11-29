import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'all_resturants_admin_state.freezed.dart';

@freezed
class AllresturantsadminState<T> with _$AllresturantsadminState {
  const factory AllresturantsadminState.initial() = _Initial;
  const factory AllresturantsadminState.loading() = Loading;
  const factory AllresturantsadminState.success(T data) = Success<T>;
  const factory AllresturantsadminState.fail(ApiErrorModel error) = Fail;
  const factory AllresturantsadminState.byCategoryLoading() = ByCategoryLoading;
  const factory AllresturantsadminState.byCategorySuccess(T data) = ByCategorySuccess<T>;
  const factory AllresturantsadminState.byCategoryFail(ApiErrorModel error) = ByCategoryFail;
  const factory AllresturantsadminState.searchResLoading() = SearchResLoading;
  const factory AllresturantsadminState.searchResSuccess(T data) = SearchResSuccess<T>;
  const factory AllresturantsadminState.searchResFail(ApiErrorModel error) = SearchResFail;
  const factory AllresturantsadminState.reatedLoading() = RatedLoading;
  const factory AllresturantsadminState.ratedSuccess(T data) = RatedSuccess<T>;
  const factory AllresturantsadminState.ratedFail(ApiErrorModel error) = RatedFail;
  const factory AllresturantsadminState.nearbyLoading() = NearbyLoading;
  const factory AllresturantsadminState.nearbySuccess(T data) = NearbySuccess<T>;
  const factory AllresturantsadminState.nearbyFail(ApiErrorModel error) = NearbyFail;
  const factory AllresturantsadminState.superCateLoading() = SuperCateLoading;
  const factory AllresturantsadminState.superCateSuccess(T data) =
      SuperCateSuccess<T>;
  const factory AllresturantsadminState.superCateFail(ApiErrorModel error) =
      SuperCateFail;
  const factory AllresturantsadminState.changeEnableLoading() =
      ChangeEnableLoading;
  const factory AllresturantsadminState.changeEnableSuccess(T data) =
      ChangeEnableSuccess<T>;
  const factory AllresturantsadminState.changeEnableFail(ApiErrorModel error) =
      ChangeEnableFail;
  const factory AllresturantsadminState.createResturantLoading() =
      CreateResturantLoading;
  const factory AllresturantsadminState.createResturantSuccess(T data) =
      CreateResturantSuccess<T>;
  const factory AllresturantsadminState.createResturantFail(
    ApiErrorModel error,
  ) = CreateResturantFail;
}
