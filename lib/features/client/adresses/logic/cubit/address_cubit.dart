import 'package:delveria/features/client/adresses/logic/cubit/address_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit()
      : super(
          AddressState(
            linkController: TextEditingController(),
            titleController: TextEditingController(),
            phoneController: TextEditingController(),
            detailsController: TextEditingController(),
            isDefault: false,
            selectedCountryCode: '+20',
            lat: 0,
            long: 0,
          ),
        );

  void updateIsDefault(bool newVal) {
    emit(state.copyWith(isDefault: newVal));
  }

  void updateLatLong(double lat, double long) {
    emit(state.copyWith(lat: lat, long: long));
  }


  @override
  Future<void> close() {
    state.titleController.dispose();
    state.phoneController.dispose();
    state.detailsController.dispose();
    state.linkController.dispose();
    return super.close();
  }
}
