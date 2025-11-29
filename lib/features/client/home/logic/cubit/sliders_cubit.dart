import 'dart:io';

import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/home/data/models/get_sliders_response.dart';
import 'package:delveria/features/client/home/data/models/search_response.dart';
import 'package:delveria/features/client/home/data/repo/sliders_repo.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlidersCubit extends Cubit<SlidersState> {
  final SlidersRepo slidersRepo;
  SlidersCubit(this.slidersRepo) : super(SlidersState.initial());
  List<SliderModel> sliders = [];
  List<File?> selectedPhotos = List<File?>.filled(5, null, growable: false);
  List<ResturantAdmin> searchResturant = [];
  List<ItemModelSearch> searchResturantItemList = [];
  void getSliders() async {
    emit(SlidersState.loading());
    try {
      final response = await slidersRepo.getSliders();
      response.when(
        success: (sliderData) {
          sliders = sliderData.slider;
          print("sliddddders");
          emit(SlidersState.success(sliderData));
        },
        failure: (error) => emit(SlidersState.fail(error)),
      );
    } catch (e) {
      emit(SlidersState.fail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> pickPhoto({required int index}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.single.path != null) {
        selectedPhotos[index] = File(result.files.single.path!);
        print(
          "📸 Photo selected at index $index: ${selectedPhotos[index]!.path}",
        );
      }
    } catch (e) {
      print("Error picking photo: $e");
    }
  }

  Future<void> saveSliderForIndex(int index , String id ) async {
    emit(SlidersState.createLoading(index));
    try {
      if (selectedPhotos[index] == null) {
        emit(
          SlidersState.createFail(
            ApiErrorHandler.handle("No photo selected at index $index"),
            index,
          ),
        );
        return;
      }
      final response = await slidersRepo.createSlider(
        image: selectedPhotos[index]!,
        resId: id
      );
      response.when(
        success: (data) => emit(SlidersState.createSuccess(data, index)),
        failure: (error) => emit(SlidersState.createFail(error, index)),
      );
    } catch (e) {
      emit(SlidersState.createFail(ApiErrorHandler.handle(e), index));
    }
  }

  Future<void> deleteSliderForIndex(int index, String sliderId) async {
    emit(SlidersState.deleteLoading(index));
    try {
      final response = await slidersRepo.deleteSlider(sliderId: sliderId);
      response.when(
        success: (data) {
          // Fix: Only clear the photo if it is not null
          if (selectedPhotos[index] != null) {
            selectedPhotos[index] = null;
          }
          emit(SlidersState.deleteSuccess(data, index));
        },
        failure: (error) => emit(SlidersState.deleteFail(error, index)),
      );
    } catch (e) {
      emit(SlidersState.deleteFail(ApiErrorHandler.handle(e), index));
    }
  }

  Future<void> searchResturantUserSide({
    required String query,
    required double lat,
    required double long,
  }) async {
    emit(SlidersState.searchRestuantUserLoading());
    try {
      final response = await slidersRepo.searchResturantUserSide(
        query: query,
        lat: lat,
        long: long,
      );
      response.when(
        success: (searchRes) {
          searchResturant = searchRes.response;
          print("❤️‍🔥 $searchResturant");
          emit(SlidersState.searchRestuantUserSuccess(searchRes));
        },
        failure: (error) => emit(SlidersState.searchRestuantUserFail(error)),
      );
    } catch (e) {
      emit(SlidersState.searchRestuantUserFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> searchResturantItem({
    required String id,
    required String query,
  }) async {
    emit(SlidersState.searchRestuantItemLoading());
    try {
      final response = await slidersRepo.searchResturantitems(
        query: query,
        id: id,
      );
      response.when(
        success: (searchRes) {
          print("enter to success");
          searchResturantItemList = searchRes.items;
          print("❤️sssssss $searchResturantItemList");
          emit(SlidersState.searchRestuantItemSuccess(searchRes));
        },
        failure: (error) => emit(SlidersState.searchRestuantItemFail(error)),
      );
    } catch (e) {
      emit(SlidersState.searchRestuantItemFail(ApiErrorHandler.handle(e)));
    }
  }
}
