import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/ResturantOwner/home/data/repo/resturant_data_repo.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

class ResturantDataCubit extends Cubit<ResturantDataState> {
  final ResturantDataRepo resturantDataRepo;
  ResturantDataCubit(this.resturantDataRepo)
    : super(ResturantDataState.initial());

  double lat = 0;
  double long = 0;
  String? cityName;
  String? resName;
  bool? isOpen;
  int? ordersNumber;
  num? netRevenue;
  double? customerFeedBack;
  List<int>? ordersOfLastWeek;

  void getResturantData() async {
    emit(ResturantDataState.loading());
    try {
      final response = await resturantDataRepo.getResturantData();
      response.when(
        success: (resData) async {
          lat = resData.restaurant.coordinates.latitude;
          long = resData.restaurant.coordinates.longitude;
          isOpen = resData.restaurant.isShow;
          resName = resData.restaurant.name;
          print("✅ $isOpen");
          await _getCityNameByLatLongOrLocationMap(
            lat,
            long,
            resData.restaurant.loacationMap,
          );
          print("city/location name: $cityName");
          emit(ResturantDataState.success(resData));
        },
        failure: (error) => emit(ResturantDataState.fail(error)),
      );
    } catch (e) {
      emit(ResturantDataState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void getResturantDataForHome() async {
    emit(ResturantDataState.getHomeResLoading());
    try {
      final response = await resturantDataRepo.getResturantDataForHome();
      response.when(
        success: (resDataHome) async {
          ordersNumber = resDataHome.totalOrders;
          netRevenue = resDataHome.netRevenue;
          customerFeedBack = resDataHome.customerFeedback;
          ordersOfLastWeek = resDataHome.ordersOfLastWeek;
          emit(ResturantDataState.getHomeResSuccess(resDataHome));
        },
        failure: (error) => emit(ResturantDataState.getHomeResFail(error)),
      );
    } catch (e) {
      emit(ResturantDataState.getHomeResFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> _getCityNameByLatLongOrLocationMap(
    double latitude,
    double longitude,
    String? locationMap,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        cityName =
            placemarks.first.name ??
            placemarks.first.locality ??
            placemarks.first.subAdministrativeArea ??
            placemarks.first.administrativeArea;
      } else {
        cityName = null;
      }
    } catch (e) {
      cityName = null;
    }
    if (cityName == null || cityName!.isEmpty) {
      cityName = locationMap;
    }
  }

  Future<void> changeEnable({required String resID}) async {
    emit(ResturantDataState.changeEnableLoading());
    try {
      final res = await resturantDataRepo.changeEnableResturantOwner(
        resID: resID,
      );
      res.when(
        success: (changeData) {
          emit(ResturantDataState.changeEnableSuccess(changeData));
        },
        failure: (error) {
          print("changeEnable error: ${error.message}");
          emit(ResturantDataState.changeEnableFail(error));
        },
      );
    } catch (e) {
      print("Exception in changeEnable: $e");
      emit(ResturantDataState.changeEnableFail(ApiErrorHandler.handle(e)));
    }
  }
}
