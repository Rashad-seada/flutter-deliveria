import 'dart:io';
import 'package:delveria/features/ResturantOwner/menu/data/models/change_enable_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/edit_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/filter_item_category_response_user.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/item_categories_response_user.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/items_category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/create_item_response.dart';

part 'item_state.freezed.dart';

@freezed
class ItemState with _$ItemState {
  const factory ItemState.initial() = ItemStateInitial;
  const factory ItemState.loading() = ItemStateLoading;
  const factory ItemState.success(CreateItemResponse data) = ItemStateSuccess;
  const factory ItemState.fail(ApiErrorModel error) = ItemStateFail;
  const factory ItemState.editLoading() = EditLoading;
  const factory ItemState.editSuccess(EditItemResponse data) = EditSuccess;
  const factory ItemState.editFail(ApiErrorModel error) = EditFail;
  const factory ItemState.getItemLoading() = GetItemLoading;
  const factory ItemState.getItemSuccess(GetAllItemsResponse data) = GetItemSuccess;
  const factory ItemState.getItemFail(ApiErrorModel error) = GetItemFail;
  const factory ItemState.deleteItemLoading() = DeleteItemLoading;
  const factory ItemState.deleteItemSuccess(EditItemResponse data) = DeleteItemSuccess;
  const factory ItemState.deleteItemFail(ApiErrorModel error) = DeleteItemFail;
  const factory ItemState.changeEnableItemLoading() = ChangeEnableItemLoading;
  const factory ItemState.changeEnableItemSuccess(ChangeEnableItemResponse data) = ChangeEnableItemSuccess;
  const factory ItemState.changeEnableItemFail(ApiErrorModel error) = ChangeEnableItemFail;
  const factory ItemState.getItemsCategoriesLoading() = GetItemsCategoriesLoading;
  const factory ItemState.getItemsCategoriesSuccess(ItemsCategoryResponse data) = GetItemsCategoriesSuccess;
  const factory ItemState.getItemsCategoriesFail(ApiErrorModel error) = GetItemsCategoriesFail;
  const factory ItemState.getItemsCategoriesUserLoading() = GetItemsCategoriesUserLoading;
  const factory ItemState.getItemsCategoriesUserSuccess(
    ItemsCategoryResponseUser data) = GetItemsCategoriesUserSuccess;
  const factory ItemState.getItemsCategoriesUserFail(ApiErrorModel error) = GetItemsCategoriesUserFail;
  
  const factory ItemState.createItemCategoriesLoading() = CreateItemCategoriesLoading;
  const factory ItemState.createItemCategoriesSuccess(CreateItemResponse data) = CreateItemCategoriesSuccess;
  const factory ItemState.createItemCategoriesFail(ApiErrorModel error) = CreateItemCategoriesFail;
  
  const factory ItemState.filterItemCategoriesLoading() = FilterItemCategoriesLoading;
  const factory ItemState.filterItemCategoriesSuccess(
    GetAllItemsResponse data) = FilterItemCategoriesSuccess;
  const factory ItemState.filterItemCategoriesFail(ApiErrorModel error) = FilterItemCategoriesFail;
  
  const factory ItemState.photoSelected(File photo) = ItemStatePhotoSelected;
}
