import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_address_state.freezed.dart';

@freezed
class CreateAddressState<T> with _$CreateAddressState {
  const factory CreateAddressState.initial() = _Initial;
  const factory CreateAddressState.loading() = Loading;
  const factory CreateAddressState.success(T data) = Success<T>;
  const factory CreateAddressState.fail(ApiErrorModel error ) = Fail;
  const factory CreateAddressState.getAddressLoading() = GetAddressLoading;
  const factory CreateAddressState.getAddressSuccess(T data) = GetAddressSuccess<T>;
  const factory CreateAddressState.getAddressFail(ApiErrorModel error ) = GetAddressFail;
  const factory CreateAddressState.deleteAddressLoading() = DeleteAddressLoading;
  const factory CreateAddressState.deleteAddressSuccess(T data) = DeleteAddressSuccess<T>;
  const factory CreateAddressState.deleteAddressFail(ApiErrorModel error ) = DeleteAddressFail;
  const factory CreateAddressState.changeEnableAddressLoading() = ChangeEnableAddressLoading;
  const factory CreateAddressState.changeEnableAddressSuccess(T data) = ChangeEnableAddressSuccess<T>;
  const factory CreateAddressState.changeEnableAddressFail(ApiErrorModel error ) = ChangeEnableAddressFail;

}
