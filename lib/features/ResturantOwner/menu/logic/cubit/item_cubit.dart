import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/item_categories_response_user.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/items_category_model.dart';
import 'package:delveria/features/ResturantOwner/menu/data/repo/items_repo.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/size_selection_widget.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/toppings_selection_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(this.itemsRepo) : super(const ItemState.initial());
  final ValueNotifier<List<SizeItem>> sizesNotifier =
      ValueNotifier<List<SizeItem>>([]);
  final ValueNotifier<List<ToppingItem>> toppingsNotifier =
      ValueNotifier<List<ToppingItem>>([]);
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? itemCategoryId = "";
  final ItemsRepo itemsRepo;
  File? selectedPhoto;

  // All items from backend (full list)
  List<ItemModel>? _allItemsFromBackend = [];

  // Paginated items to display
  List<ItemModel>? allItems = [];

  RestaurantModel? resturant;
  int isSelectedFilter = 0;
  List<ItemCategory> allItemsCategories = [];
  List<ItemCategoryUser> allItemsCategoriesUser = [];

  // Client-side pagination variables
  int currentPage = 1;
  int itemsPerPage = 5; // Number of items to show per page
  bool hasMoreItems = true;

  void onSizesChanged(List<SizeItem> sizes) {
    sizesNotifier.value = List<SizeItem>.from(sizes);
    print("🍔 Sizes updated: ${sizes.length} items");
    for (int i = 0; i < sizes.length; i++) {
      print(
        "  Size $i: ${sizes[i].sizeController.text} - Before: ${sizes[i].priceBeforeController.text} - After: ${sizes[i].priceAfterController.text}",
      );
    }
  }

  void updateItemCazegoryId(String newVal) {
    itemCategoryId = newVal;
  }

  void updateIsSelectedFilter(int newVal) {
    isSelectedFilter = newVal;
  }

  void resetPagination() {
    currentPage = 1;
    hasMoreItems = true;
    allItems = [];
    _loadItemsForCurrentPage();
  }

  // Load items for current page from the full list
  void _loadItemsForCurrentPage() {
    if (_allItemsFromBackend == null || _allItemsFromBackend!.isEmpty) {
      allItems = [];
      hasMoreItems = false;
      return;
    }

    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (startIndex >= _allItemsFromBackend!.length) {
      hasMoreItems = false;
      return;
    }

    final itemsToAdd = _allItemsFromBackend!.sublist(
      startIndex,
      endIndex > _allItemsFromBackend!.length
          ? _allItemsFromBackend!.length
          : endIndex,
    );

    allItems = [...(allItems ?? []), ...itemsToAdd];
    hasMoreItems = endIndex < _allItemsFromBackend!.length;
  }

  // Load more items (next page)
  void loadMoreItems() {
    if (!hasMoreItems) return;

    currentPage++;
    _loadItemsForCurrentPage();
    emit(
      ItemState.getItemSuccess(
        GetAllItemsResponse(
          response: GetAllItemsResponseData(items: allItems, restaurant: resturant),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descriptionController.dispose();
    return super.close();
  }

  void onToppingsChanged(List<ToppingItem> toppings) {
    toppingsNotifier.value = List<ToppingItem>.from(toppings);
    print("🍕 Toppings updated: ${toppings.length} items");
    for (int i = 0; i < toppings.length; i++) {
      print(
        "  Topping $i: ${toppings[i].nameController.text} - Price: ${toppings[i].priceController.text}",
      );
    }
  }

  void saveItem(BuildContext context, bool haveOption) async {
    final currentSizes = sizesNotifier.value;
    final currentToppings = toppingsNotifier.value;

    print("💾 Saving item with:");
    print("   Name: ${nameController.text}");
    print("   Description: ${descriptionController.text}");
    print("   Sizes: ${currentSizes.length}");
    print("   Toppings: ${currentToppings.length}");

    if (nameController.text.trim().isEmpty) {
      showWarningSnackBar(context, "Please enter item name");
      return;
    }

    if (currentSizes.isEmpty) {
      showWarningSnackBar(context, "Please add at least one size");
      return;
    }

    if (selectedPhoto == null) {
      showWarningSnackBar(context, "Please select a photo");
      return;
    }

    for (int i = 0; i < currentSizes.length; i++) {
      final size = currentSizes[i];
      if (size.sizeController.text.trim().isEmpty) {
        showWarningSnackBar(context, "Please fill size name for item ${i + 1}");
        return;
      }
      if (size.priceBeforeController.text.trim().isEmpty) {
        showWarningSnackBar(
          context,
          "Please fill original price for size ${i + 1}",
        );
        return;
      }
      if (size.priceBeforeController.text == "0") {
        showWarningSnackBar(
          context,
          " the original price for size ${i + 1} can't be 0",
        );
        return;
      }
      if (size.priceAfterController.text.trim().isEmpty) {
        showWarningSnackBar(
          context,
          "Please fill discounted price for size ${i + 1}",
        );
        return;
      }
      if (size.priceAfterController.text == "0") {
        showWarningSnackBar(
          context,
          " the  price after for size ${i + 1} can't be 0",
        );
        return;
      }
    }

    for (int i = 0; i < currentToppings.length; i++) {
      final topping = currentToppings[i];
      if (topping.nameController.text.trim().isEmpty) {
        showWarningSnackBar(
          context,
          "Please fill topping name for item ${i + 1}",
        );
        return;
      }
      if (topping.priceController.text.trim().isEmpty) {
        showWarningSnackBar(context, "Please fill price for topping ${i + 1}");
        return;
      }
    }
    if (itemCategoryId?.isEmpty == true || itemCategoryId == "") {
      showWarningSnackBar(context, "Please choose item category ");
      return;
    }

    await createMenuItem(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      itemCategory: itemCategoryId ?? "",
      sizes: currentSizes,
      toppings: currentToppings,
      haveoption: haveOption,
    );
  }

  Future<void> pickPhoto() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.single.path != null) {
        selectedPhoto = File(result.files.single.path!);
        print("📸 Photo selected: ${selectedPhoto!.path}");
        emit(ItemState.photoSelected(selectedPhoto!));
      }
    } catch (e) {
      print("Error picking photo: $e");
      emit(ItemState.fail(ApiErrorHandler.handle("Error selecting photo: $e")));
    }
  }

  List<Map<String, dynamic>> _sizesToJson(List<SizeItem> sizes) {
    return sizes
        .map(
          (size) => {
            'size': size.sizeController.text.trim(),
            'price_before': double.parse(
              size.priceBeforeController.text.trim(),
            ),
            'price_after': double.parse(size.priceAfterController.text.trim()),
          },
        )
        .toList();
  }

  List<Map<String, dynamic>> _toppingsToJson(List<ToppingItem> toppings) {
    return toppings
        .map(
          (topping) => {
            'topping': topping.nameController.text.trim(),
            'price': double.parse(topping.priceController.text.trim()),
          },
        )
        .toList();
  }

  Future<void> createMenuItem({
    required String name,
    required String description,
    required String itemCategory,
    required List<SizeItem> sizes,
    required List<ToppingItem> toppings,
    required bool haveoption,
  }) async {
    try {
      print("🚀 Starting createMenuItem...");
      emit(const ItemState.loading());

      if (selectedPhoto == null) {
        print("❌ No photo selected");
        emit(ItemState.fail(ApiErrorHandler.handle("No photo selected")));
        return;
      }

      if (name.trim().isEmpty) {
        print("❌ Name ");
        emit(
          ItemState.fail(
            ApiErrorHandler.handle("Name and description are required"),
          ),
        );
        return;
      }

      if (sizes.isEmpty) {
        print("❌ No sizes provided");
        emit(
          ItemState.fail(
            ApiErrorHandler.handle("At least one size is required"),
          ),
        );
        return;
      }

      for (int i = 0; i < sizes.length; i++) {
        final size = sizes[i];
        if (size.priceBeforeController.text.trim().isEmpty) {
          emit(
            ItemState.fail(
              ApiErrorHandler.handle(
                "Please fill original price for size ${i + 1}",
              ),
            ),
          );
          return;
        }
        if (size.priceAfterController.text.trim().isEmpty) {
          emit(
            ItemState.fail(
              ApiErrorHandler.handle(
                "Please fill discounted price for size ${i + 1}",
              ),
            ),
          );
          return;
        }
      }

      final sizesJson = _sizesToJson(sizes);
      final toppingsJson = _toppingsToJson(toppings);

      print("Converted data:");
      print("   Sizes JSON: $sizesJson");
      print("   Toppings JSON: $toppingsJson");

      final response = await itemsRepo.createItem(
        photo: selectedPhoto!,
        name: name,
        description: description,
        itemCategory: itemCategory,
        sizes: jsonEncode(sizesJson),
        toppings: jsonEncode(toppingsJson),
        have_option: haveoption,
      );

      print("API call completed");

      response.when(
        success: (data) {
          print("✅ Success: $data");
          emit(ItemState.success(data));
        },
        failure: (error) {
          print("❌ API Error: ${error.message}");
          emit(ItemState.fail(ApiErrorHandler.handle(error.message)));
        },
      );
    } catch (e) {
      print("💥 Exception in createMenuItem: $e");
      emit(ItemState.fail(ApiErrorHandler.handle(e.toString())));
    }
  }

  Future<void> deleteItem({required String itemId}) async {
    emit(ItemState.deleteItemLoading());
    try {
      final response = await itemsRepo.deleteItem(itemId: itemId);
      response.when(
        success: (itemRes) {
          emit(DeleteItemSuccess(itemRes));
        },
        failure: (error) => emit(DeleteItemFail(error)),
      );
    } catch (e) {
      emit(DeleteItemFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> changeEnableItem({
    required String itemId,
    required String resId,
  }) async {
    emit(ItemState.changeEnableItemLoading());
    try {
      final response = await itemsRepo.changeEnableItem(id: itemId);
      response.when(
        success: (itemRes) {
          emit(ItemState.changeEnableItemSuccess(itemRes));
          getAllItems(resId: resId);
        },
        failure: (error) => emit(ItemState.changeEnableItemFail(error)),
      );
    } catch (e) {
      emit(ItemState.changeEnableItemFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> editMenuItem({
    required String itemId,
    required String name,
    required String description,
    required List<SizeItem> sizes,
    required List<ToppingItem> toppings,
  }) async {
    try {
      print("🚀 Starting editMenuItem...");
      emit(const ItemState.editLoading());

      if (name.trim().isEmpty || description.trim().isEmpty) {
        print("❌ Name or description is empty");
        emit(
          ItemState.editFail(
            ApiErrorHandler.handle("Name and description are required"),
          ),
        );
        return;
      }

      if (sizes.isEmpty) {
        print("❌ No sizes provided");
        emit(
          ItemState.editFail(
            ApiErrorHandler.handle("At least one size is required"),
          ),
        );
        return;
      }

      for (int i = 0; i < sizes.length; i++) {
        final size = sizes[i];
        if (size.priceBeforeController.text.trim().isEmpty) {
          emit(
            ItemState.editFail(
              ApiErrorHandler.handle(
                "Please fill original price for size ${i + 1}",
              ),
            ),
          );
          return;
        }
        if (size.priceAfterController.text.trim().isEmpty) {
          emit(
            ItemState.editFail(
              ApiErrorHandler.handle(
                "Please fill discounted price for size ${i + 1}",
              ),
            ),
          );
          return;
        }
      }

      final sizesJson = _sizesToJson(sizes);
      final toppingsJson = _toppingsToJson(toppings);

      print("📊 Converted data:");
      print("   Sizes JSON: $sizesJson");
      print("   Toppings JSON: $toppingsJson");

      final response = await itemsRepo.editItem(
        itemId: itemId,
        name: name,
        description: description,
        sizes: jsonEncode(sizesJson),
        toppings: jsonEncode(toppingsJson),
      );

      print("📡 API call completed");

      response.when(
        success: (data) {
          print("✅ Edit Success: $data");
          emit(ItemState.editSuccess(data));
        },
        failure: (error) {
          print("❌ API Error: ${error.message}");
          emit(ItemState.editFail(ApiErrorHandler.handle(error.message)));
        },
      );
    } catch (e) {
      print("💥 Exception in editMenuItem: $e");
      emit(ItemState.editFail(ApiErrorHandler.handle(e.toString())));
    }
  }

  Future<void> getAllItems({required String resId}) async {
    emit(ItemState.getItemLoading());
    try {
      final res = await itemsRepo.getAllItem(code: resId);
      res.when(
        success: (itemRes) {
          // Store all items from backend
          _allItemsFromBackend = itemRes.response?.items;
          resturant = itemRes.response?.restaurant;

          // Reset pagination and load first page
          currentPage = 1;
          allItems = [];
          _loadItemsForCurrentPage();

          emit(ItemState.getItemSuccess(itemRes));
        },
        failure: (error) => emit(ItemState.getItemFail(error)),
      );
    } catch (e) {
      emit(ItemState.getItemFail(ApiErrorHandler.handle(e)));
    }
  }

  void getItemCategories() async {
    emit(ItemState.getItemsCategoriesLoading());
    try {
      final response = await itemsRepo.getItemCategories();
      response.when(
        success: (itemCateRes) {
          allItemsCategories = itemCateRes.itemCategories;
          emit(ItemState.getItemsCategoriesSuccess(itemCateRes));
        },
        failure: (error) => emit(ItemState.getItemsCategoriesFail(error)),
      );
    } catch (e) {
      emit(ItemState.getItemsCategoriesFail(ApiErrorHandler.handle(e)));
    }
  }

  void getItemCategoriesUser({required String resId}) async {
    emit(ItemState.getItemsCategoriesUserLoading());
    try {
      final response = await itemsRepo.getItemCategoriesUser(resId: resId);
      response.when(
        success: (itemCateRes) {
          allItemsCategoriesUser = itemCateRes.itemCategories;
          emit(ItemState.getItemsCategoriesUserSuccess(itemCateRes));
        },
        failure: (error) => emit(ItemState.getItemsCategoriesUserFail(error)),
      );
    } catch (e) {
      emit(ItemState.getItemsCategoriesUserFail(ApiErrorHandler.handle(e)));
    }
  }

  void filterItemCategoriesUser({
    required String cateId,
    required String resId,
  }) async {
    emit(ItemState.filterItemCategoriesLoading());
    try {
      final response = await itemsRepo.filterItemCategoriesUser(
        cateId: cateId,
        resId: resId,
      );
      response.when(
        success: (itemCateRes) {
          _allItemsFromBackend = itemCateRes.response?.items ?? [];

          // Reset pagination and load first page
          currentPage = 1;
          allItems = [];
          _loadItemsForCurrentPage();

          print("filter itemssss $allItems");
          emit(ItemState.filterItemCategoriesSuccess(itemCateRes));
        },
        failure: (error) => emit(ItemState.filterItemCategoriesFail(error)),
      );
    } catch (e) {
      emit(ItemState.filterItemCategoriesFail(ApiErrorHandler.handle(e)));
    }
  }

  void createItemCategories({required Map<String, dynamic> body}) async {
    emit(ItemState.createItemCategoriesLoading());
    try {
      final response = await itemsRepo.createItemCategory(body: body);
      response.when(
        success: (itemCateRes) {
          emit(ItemState.createItemCategoriesSuccess(itemCateRes));
        },
        failure: (error) => emit(ItemState.createItemCategoriesFail(error)),
      );
    } catch (e) {
      emit(ItemState.createItemCategoriesFail(ApiErrorHandler.handle(e)));
    }
  }
}
