import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'filter_category_state.freezed.dart';

@freezed
class FilterCategoryState<T> with _$FilterCategoryState {
  const factory FilterCategoryState.initial() = _Initial;
  const factory FilterCategoryState.loading() = Loading;
  const factory FilterCategoryState.success(T data) = Success<T>;
  const factory FilterCategoryState.fail(ApiErrorModel erro) = Fail;
  const factory FilterCategoryState.sortByPriceLoading() = SortByPriceLoading;
  const factory FilterCategoryState.sortByPriceSuccess(T data) = SortByPriceSuccess<T>;
  const factory FilterCategoryState.sortByPriceFail(ApiErrorModel erro) = SortByPriceFail;
}
