import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/adresses/data/models/add_address_request.dart';
import 'package:delveria/features/client/adresses/data/models/get_addresses_response.dart';
import 'package:delveria/features/client/adresses/data/repo/address_repo.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAddressCubit extends Cubit<CreateAddressState> {
  final AddressRepo addressRepo;
  CreateAddressCubit(this.addressRepo) : super(CreateAddressState.initial());
  List<AddressModel> addresses = [];
  double lat = 0;
  double long = 0;
  String? addressValue;

  void createAddress({
    required AddAddressRequest address,
    required BuildContext context,
  }) async {
    emit(CreateAddressState.loading());
    try {
      final response = await addressRepo.createAddress(address: address);
      response.when(
        success: (addressRes) {
          emit(CreateAddressState.success(addressRes));
        },
        failure: (error) => emit(CreateAddressState.fail(error)),
      );
    } catch (e) {
      emit(CreateAddressState.fail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> deleteAddress({required String addressId}) async {
    emit(CreateAddressState.deleteAddressLoading());
    try {
      final response = await addressRepo.deleteAddress(addressId: addressId);
      response.when(
        success: (addressRes) {
          emit(CreateAddressState.deleteAddressSuccess(addressRes));
        },
        failure: (error) => emit(CreateAddressState.deleteAddressFail(error)),
      );
    } catch (e) {
      emit(CreateAddressState.deleteAddressFail(ApiErrorHandler.handle(e)));
    }
  }
  Future<void> changeDefaultAdress({required String addressId}) async {
    emit(CreateAddressState.changeEnableAddressLoading());
    try {
      final response = await addressRepo.changeDefault(addressId: addressId);
      response.when(
        success: (addressRes) {
          emit(CreateAddressState.changeEnableAddressSuccess(addressRes));
        },
        failure: (error) => emit(CreateAddressState.changeEnableAddressFail(error)),
      );
    } catch (e) {
      emit(CreateAddressState.changeEnableAddressFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getAdresses() async {
    // Skip for guests - they don't have saved addresses but use geolocation
    final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
    if (isGuest) {
      addresses = [];
      // Get location from SharedPreferences (saved during guest login)
      lat = await SharedPrefHelper.getDouble(SharedPrefKeys.lat);
      long = await SharedPrefHelper.getDouble(SharedPrefKeys.long);
      lat = await SharedPrefHelper.getDouble(SharedPrefKeys.lat);
      long = await SharedPrefHelper.getDouble(SharedPrefKeys.long);
      
      final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

      emit(CreateAddressState.getAddressSuccess(GetAddressesResponse(success: true, address: [])));
      return;
    }
    
    emit(CreateAddressState.getAddressLoading());
    try {
      final response = await addressRepo.getAdresses();
      response.when(
        success: (addressRes) async {
          if (addressRes.address.isEmpty) {
            print("addressRes.address is empty");
            emit(
              CreateAddressState.getAddressFail(
                ApiErrorHandler.handle("No addresses found"),
              ),
            );
            return;
          }
          // Fetch and use the last address
          addresses = addressRes.address;

          final lastAddress = addresses.last;

          if (lastAddress.coordinates == null) {
            print("Last address coordinates are null");
            emit(
              CreateAddressState.getAddressFail(
                ApiErrorHandler.handle("Last address coordinates are null"),
              ),
            );
            return;
          }

          // Print and set lat/long with explicit logs
          print('SharedPrefHelper : getDouble with key : lat');
          print('SharedPrefHelper : getDouble with key : long');
          print('SharedPrefHelper : getString with key : userName');
          print(addresses.length);
          print(lastAddress.coordinates?.latitude);

          await SharedPrefHelper.setData(
            SharedPrefKeys.lat,
            lastAddress.coordinates?.latitude,
          );
          await SharedPrefHelper.setData(
            SharedPrefKeys.long,
            lastAddress.coordinates?.longitude,
          );

          lat = await SharedPrefHelper.getDouble(SharedPrefKeys.lat);
          long = await SharedPrefHelper.getDouble(SharedPrefKeys.long);

          emit(CreateAddressState.getAddressSuccess(addressRes));
          print(lat);
          print(long);
        },
        failure: (error) {
          print("Failed to get addresses: $error");
          emit(CreateAddressState.getAddressFail(error));
        },
      );
    } catch (e) {
      print("Exception in getAdresses: $e");
      emit(CreateAddressState.getAddressFail(ApiErrorHandler.handle(e)));
    }
  }
}
