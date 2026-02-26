import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';
import 'package:delveria/features/client/filter/data/repo/filter_category_repo.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCategoryCubit extends Cubit<FilterCategoryState> {
  final FilterCategoryRepo filterCategoryRepo;
  FilterCategoryCubit(this.filterCategoryRepo)
    : super(FilterCategoryState.initial());
  List<RestaurantByCategory> resturants = [];
  List<SortByPriceItem> sortedPriceItems = [];
  void filterByCategory({
    required String superId,
    required String subId,
    required double lat,
    required double long,
  }) async {
    if (!isClosed) emit(FilterCategoryState.loading());
    try {
      final respone = await filterCategoryRepo.filterByCategory(
        superId: superId,
        subId: subId,
        lat: lat,
        long: long,
      );
      if (isClosed) return;
      respone.when(
        success: (filterCateRes) {
          resturants = filterCateRes.response;
          if (!isClosed) emit(FilterCategoryState.success(filterCateRes));
        },
        failure: (error) {
          if (!isClosed) emit(FilterCategoryState.fail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(FilterCategoryState.fail(ApiErrorHandler.handle(e)));
    }
  }

 Future <void> sortByPrice({required String resId}) async {
    if (!isClosed) emit(FilterCategoryState.sortByPriceLoading());
    try {
      final response = await filterCategoryRepo.sortByPrice(resId: resId);
      if (isClosed) return;
      response.when(
        success: (sortRes) {
          sortedPriceItems = sortRes.response;
          if (!isClosed) emit(FilterCategoryState.sortByPriceSuccess(sortRes));
        },
        failure: (error) {
          if (!isClosed) emit(FilterCategoryState.sortByPriceFail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(FilterCategoryState.sortByPriceFail(ApiErrorHandler.handle(e)));
    }
  }
}
