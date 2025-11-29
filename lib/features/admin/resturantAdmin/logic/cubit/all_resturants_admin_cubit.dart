import 'dart:io';

import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_request.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/repo/resturant_admin_repo.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart'
    as cate;
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart'
    show NearbyRestaurant;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllresturantsadminCubit extends Cubit<AllresturantsadminState> {
  final ResturantAdminRepo resturantAdminRepo;
  AllresturantsadminCubit(this.resturantAdminRepo)
    : super(AllresturantsadminState.initial());

  List<ResturantAdmin> allResturants = [];
  List<ResturantAdmin> searchResturants = [];
  List<ResturantAdmin> allRatedResturants = [];
  List<bool>? changeEnableButton;
  bool? isOpen;

  // Updated fields for multiple categories support
  Map<String, String> selectedSuperCategories = {}; // id -> name
  Map<String, Map<String, String>> selectedSubCategories =
      {}; // superId -> {subId: subName}
  List<String> categoryIds = []; // List of selected super category IDs
  List<String> subcategoryIds = []; // List of selected subcategory IDs

  List<SuperCategoryInSuper> allSuperCategories = [];
  List<SubCategory> allSubCategories = [];
  File? selectedPhoto;
  File? selectedLogo;
  TimeOfDay fromTime = const TimeOfDay(hour: 17, minute: 0);
  TimeOfDay toTime = const TimeOfDay(hour: 15, minute: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deliveryCostController = TextEditingController();
  TextEditingController estimatedTimeController = TextEditingController();
  List<NearbyRestaurant> allNearbyResturant = [];
  List<cate.RestaurantByCategory> categoryResturants = [];

  // Updated method to handle multiple categories
  void updateSelectedCategories(
    Map<String, String> superCategories,
    Map<String, Map<String, String>> subCategories,
  ) {
    selectedSuperCategories = Map.from(superCategories);
    selectedSubCategories = Map.from(subCategories);

    // Update the lists for API calls
    categoryIds = superCategories.keys.toList();
    subcategoryIds = [];

    // Collect all selected subcategory IDs
    for (var subCategoryMap in subCategories.values) {
      subcategoryIds.addAll(subCategoryMap.keys);
    }

    print("Selected Super Categories: $selectedSuperCategories");
    print("Selected Sub Categories: $selectedSubCategories");
    print("Category IDs: $categoryIds");
    print("Subcategory IDs: $subcategoryIds");
  }

  // Keep backward compatibility methods (can be deprecated later)
  @Deprecated('Use updateSelectedCategories instead')
  void updateSelectedCategory({
    required String newVal,
    required String cateId,
  }) {
    // For backward compatibility, update the new structure
    selectedSuperCategories[cateId] = newVal;
    categoryIds = [cateId];
  }

  @Deprecated('Use updateSelectedCategories instead')
  void updateSelectedSubCategory({
    required String newVal,
    required String subCatId,
  }) {
    // For backward compatibility
    if (categoryIds.isNotEmpty) {
      selectedSubCategories[categoryIds.first] = {subCatId: newVal};
      subcategoryIds = [subCatId];
    }
  }

  Future<void> pickPhoto() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
        selectedPhoto = File(result.files.single.path!);
      }
    } catch (e) {
      print("Error picking photo: $e");
    }
  }

  Future<void> pickLogo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.single.path != null) {
        selectedLogo = File(result.files.single.path!);
      }
    } catch (e) {
      print("Error picking logo: $e");
    }
  }

  Future<void> getAllResturantsForAdmin() async {
    emit(AllresturantsadminState.loading());
    try {
      await resetHeaders();

      final res = await resturantAdminRepo.getAllResturantsforAdmin();
      res.when(
        success: (resturantRes) {
          allResturants.clear();
          allResturants.addAll(resturantRes.response);
          print("alllllllll$allResturants");
          isOpen = resturantRes.response.map((e) => e.isOpen).first;
          changeEnableButton =
              resturantRes.response.map((e) => e.isShow).toList();
          emit(AllresturantsadminState.success(resturantRes));
        },
        failure: (error) {
          print("getAllResturantsForAdmin error: ${error.message}");
          emit(AllresturantsadminState.fail(error));
        },
      );
    } catch (e) {
      print("Exception in getAllResturantsForAdmin: $e");
      emit(AllresturantsadminState.fail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getAllRatedResturantsForAdmin(double? lat, double? long) async {
    emit(AllresturantsadminState.reatedLoading());
    try {
      await resetHeaders();

      final res = await resturantAdminRepo.getAllRatedResturantsforAdmin(
        lat: lat ?? 0,
        long: long ?? 0,
      );
      res.when(
        success: (resturantRes) {
          allRatedResturants.clear();
          allRatedResturants.addAll(resturantRes.response);
          print("✅ all rated $allRatedResturants");
          emit(AllresturantsadminState.ratedSuccess(resturantRes));
        },
        failure: (error) {
          print("getAllRatedResturantsForAdmin error: ${error.message}");
          emit(AllresturantsadminState.ratedFail(error));
        },
      );
    } catch (e) {
      print("Exception in getAllRatedResturantsForAdmin: $e");
      emit(AllresturantsadminState.ratedFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getAllRatedResturantsWithoutLocation() async {
    emit(AllresturantsadminState.reatedLoading());
    try {
      await resetHeaders();

      final res =
          await resturantAdminRepo.getAllRatedResturantsWithoutLocation();
      res.when(
        success: (resturantRes) {
          allRatedResturants.clear();
          allRatedResturants.addAll(resturantRes.response);
          print("✅ all rated $allRatedResturants");
          emit(AllresturantsadminState.ratedSuccess(resturantRes));
        },
        failure: (error) {
          print("getAllRatedResturantsForAdmin error: ${error.message}");
          emit(AllresturantsadminState.ratedFail(error));
        },
      );
    } catch (e) {
      print("Exception in getAllRatedResturantsForAdmin: $e");
      emit(AllresturantsadminState.ratedFail(ApiErrorHandler.handle(e)));
    }
  }

  void getAllSuperCategories() async {
    emit(AllresturantsadminState.superCateLoading());
    try {
      await resetHeaders();

      final res = await resturantAdminRepo.getAllSuperCategories();
      res.when(
        success: (supercateRes) {
          allSuperCategories.clear();
          allSuperCategories.addAll(supercateRes.response);
          emit(AllresturantsadminState.superCateSuccess(supercateRes));
        },
        failure: (error) {
          print("getAllSuperCategories error: ${error.message}");
          emit(AllresturantsadminState.ratedFail(error));
        },
      );
    } catch (e) {
      print("Exception in getAllSuperCategories: $e");
      emit(AllresturantsadminState.ratedFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> changeEnable({required String resID, int? index}) async {
    emit(AllresturantsadminState.changeEnableLoading());
    try {
      await resetHeaders();

      final res = await resturantAdminRepo.changeEnable(resID: resID);
      res.when(
        success: (changeData) {
          if (index != null &&
              changeEnableButton != null &&
              index < changeEnableButton!.length) {
            if (!changeData.message.contains("disabled")) {
              changeEnableButton![index] = !changeEnableButton![index];
            }
          }
          emit(AllresturantsadminState.changeEnableSuccess(changeData));
        },
        failure: (error) {
          print("changeEnable error: ${error.message}");
          emit(AllresturantsadminState.changeEnableFail(error));
        },
      );
    } catch (e) {
      print("Exception in changeEnable: $e");
      emit(AllresturantsadminState.changeEnableFail(ApiErrorHandler.handle(e)));
    }
  }

  void creatResturantWithPickedFiles(CreatResturantRequest req) async {
    emit(AllresturantsadminState.createResturantLoading());
    try {
      if (selectedPhoto == null || selectedLogo == null) {
        emit(
          AllresturantsadminState.createResturantFail(
            ApiErrorHandler.handle("Please select both photo and logo files."),
          ),
        );
        return;
      }

      // Validation for multiple categories
      if (categoryIds.isEmpty) {
        emit(
          AllresturantsadminState.createResturantFail(
            ApiErrorHandler.handle(
              "You must choose at least one super category",
            ),
          ),
        );
        return;
      }

      if (subcategoryIds.isEmpty) {
        emit(
          AllresturantsadminState.createResturantFail(
            ApiErrorHandler.handle(
              "You must choose subcategories for all selected super categories",
            ),
          ),
        );
        return;
      }

      await setMultiPartHeaders();

      final res = await resturantAdminRepo.creatResturantIndexed(
        photo: selectedPhoto!,
        logo: selectedLogo!,
        creatRes: req,
      );

      await resetHeaders();
      print("❌ will refresh token ");
      await refreshToken();
      res.when(
        success: (creatRes) {
          if (creatRes.message.contains("Error")) {
            emit(
              AllresturantsadminState.createResturantFail(
                ApiErrorHandler.handle(creatRes.message),
              ),
            );
          } else {
            emit(AllresturantsadminState.createResturantSuccess(creatRes));
          }
        },
        failure: (error) {
          emit(AllresturantsadminState.createResturantFail(error));
        },
      );
    } catch (e) {
      await resetHeaders();
      emit(
        AllresturantsadminState.createResturantFail(ApiErrorHandler.handle(e)),
      );
    }
  }

  Future<void> setMultiPartHeaders() async {
    DioFactory.setMutliPartHeaders();
  }

  Future<void> refreshToken() async {
    DioFactory.setTokenIntoHeaderAfterLogin(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
    );
  }

  Future<void> resetHeaders() async {
    DioFactory.setJsonHeaders();
  }

  Future<void> getNearbyResturants({
    BuildContext? context,
    double? lat,
    double? long,
  }) async {
    print(lat);
    print(long);
    emit(AllresturantsadminState.nearbyLoading());
    try {
      await resetHeaders();

      final response = await resturantAdminRepo.getNearbyResponse(
        lat: lat ?? 0,
        long: long ?? 0,
      );
      response.when(
        success: (nearbyData) {
          allNearbyResturant = nearbyData.response;
          emit(AllresturantsadminState.nearbySuccess(nearbyData));
        },
        failure: (error) => emit(AllresturantsadminState.nearbyFail(error)),
      );
    } catch (e) {
      emit(AllresturantsadminState.nearbyFail(ApiErrorHandler.handle(e)));
    }
  }

  void filterByCategoryAdmin({
    required String superId,
    required String subId,
  }) async {
    emit(AllresturantsadminState.byCategoryLoading());
    try {
      await resetHeaders();

      final respone = await resturantAdminRepo.filterByCategoryAdmin(
        superId: superId,
        subId: subId,
      );
      respone.when(
        success: (filterCateRes) {
          categoryResturants = filterCateRes.response;
          emit(AllresturantsadminState.byCategorySuccess(filterCateRes));
        },
        failure: (error) => emit(AllresturantsadminState.byCategoryFail(error)),
      );
    } catch (e) {
      emit(AllresturantsadminState.byCategoryFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> searchResturant({required String query}) async {
    emit(AllresturantsadminState.searchResLoading());
    try {
      await resetHeaders();

      final response = await resturantAdminRepo.searchResturant(query: query);
      response.when(
        success: (searchRes) {
          searchResturants = searchRes.response;
          print("❤️‍🔥 $searchResturants");
          emit(AllresturantsadminState.searchResSuccess(searchRes));
        },
        failure: (error) => emit(AllresturantsadminState.searchResFail(error)),
      );
    } catch (e) {
      emit(AllresturantsadminState.searchResFail(ApiErrorHandler.handle(e)));
    }
  }
}
