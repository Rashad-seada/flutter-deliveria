import 'dart:io';

import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/data/repo/resturant_profile_repo.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_state.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

class ResturantProfileDataCubit extends Cubit<ResturantProfileDataState> {
  final ResturantProfileRepo resturantProfileRepo;
  ResturantProfileDataCubit(this.resturantProfileRepo)
    : super(ResturantProfileDataState.initial());
  String? photo;
  String? logo;
  String name = "";
  String address = "";
  String phone = "";
  String openHour = "";
  String closeHour = "";
  String cityName = "";
  List<Review> reviews = [];
  bool? isOpen;
  bool isUpdate = false;
  double? lat, long;
  String? aboutUs;
  String? estimatedTime;
  String? locationMap;
  String? password;
  String? id;
  List<String>? superCategories;
  List<String>? subCategories;
  TextEditingController nameController = TextEditingController();
  void toggleUpdate() {
    isUpdate = !isUpdate;
  }

  Future<void> getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.locality ?? "";
        address = [
          placemarks.first.street,
          placemarks.first.subLocality,
          placemarks.first.locality,
          placemarks.first.administrativeArea,
          placemarks.first.country,
        ].where((e) => e != null && e.isNotEmpty).join(', ');
      }
    } catch (e) {
      cityName = "";
      address = "";
    }
  }

  Future<void> updateRestaurantData(
    CreatResturantRequest creatReq,
    File? photo,
    File? logo,
    String id,
  ) async {
    emit(ResturantProfileDataState.loadingUpdate());
    try {
      print("enter cubit ");
      final response = await resturantProfileRepo.updateRestaurnatInfo(
        photo: photo,
        logo: logo,
        creatRes: creatReq,
        id: id,
      );
      response.when(
        success: (data) {
          print("enter success ");
          emit(ResturantProfileDataState.successUpdate(data));
          getResturantProfileData();
        },
        failure: (error) {
          print(error.message);
          emit(ResturantProfileDataState.failUpdate(error));
        },
      );
    } catch (e) {
      emit(ResturantProfileDataState.failUpdate(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getResturantProfileData() async {
    emit(ResturantProfileDataState.loading());
    try {
      final response = await resturantProfileRepo.getResturantData();
      response.when(
        success: (resturantProfiledata) async {
          final restaurant = resturantProfiledata.restaurant;
          print("resphoto ${restaurant?.photo}");
          photo = restaurant?.photo ?? "";
          photo = restaurant?.logo ?? "";
          name = restaurant?.name ?? "";
          phone = restaurant?.phone ?? "";
          openHour = restaurant?.openHour ?? "";
          closeHour = restaurant?.closeHour ?? "";
          reviews = restaurant?.reviews ?? [];
          isOpen = restaurant?.isShow;
          lat = restaurant?.coordinates?.latitude;
          long = restaurant?.coordinates?.longitude;
          aboutUs = restaurant?.aboutUs;
          superCategories = restaurant?.superCategory;
          subCategories = restaurant?.subCategory;
          estimatedTime = restaurant?.estimatedTime.toString();
          locationMap = restaurant?.loacationMap;
          password = restaurant?.password;
          id = restaurant?.id;

          final coordinates = restaurant?.coordinates;
          if (coordinates?.latitude != null && coordinates?.longitude != null) {
            await getCityName(coordinates!.latitude!, coordinates.longitude!);
          } else {
            address = "";
            cityName = "";
          }

          if (!isClosed) emit(ResturantProfileDataState.success(resturantProfiledata));
        },
        failure: (error) {
          emit(ResturantProfileDataState.fail(error));
        },
      );
    } catch (e) {
      // Optionally emit a failure state here
    }
  }
}
