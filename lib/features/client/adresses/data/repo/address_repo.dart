import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/api_result.dart';
import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/features/client/adresses/data/models/add_address_request.dart';
import 'package:delveria/features/client/adresses/data/models/address_response.dart';
import 'package:delveria/features/client/adresses/data/models/delete_address_response.dart';
import 'package:delveria/features/client/adresses/data/models/get_addresses_response.dart';

class AddressRepo {
  final ApiServices apiServices;

  AddressRepo({required this.apiServices});

  Future<ApiResult<AddressResponse>> createAddress({
    required AddAddressRequest address,
  }) async {
    try {
      final res = await apiServices.createAddress(address);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<GetAddressesResponse>> getAdresses() async {
    try {
      final res = await apiServices.getAddress({});
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult<DeleteAddressResponse>> deleteAddress({required String addressId}) async {
    try {
      final res = await apiServices.deleteAddress(addressId, {} );
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  Future<ApiResult> changeDefault({required String addressId}) async {
    try {
      final res = await apiServices.changeDefault(addressId, {} );
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
