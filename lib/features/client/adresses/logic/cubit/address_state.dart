import 'package:delveria/features/client/adresses/data/models/address.dart';
import 'package:flutter/material.dart';

class AddressState {
  final TextEditingController titleController;
  final TextEditingController phoneController;
  final TextEditingController detailsController;
  final TextEditingController linkController;
  final double lat;
  final double long;
  final bool isDefault; //false
  // '+20';
  final String selectedCountryCode;
  final Address? address;

  AddressState({
    required this.titleController,
    required this.phoneController,
    required this.detailsController,
    required this.isDefault,
    required this.selectedCountryCode,
    required this.linkController,
    required this.lat,
    required this.long,
    this.address,
  });
  AddressState copyWith({
    TextEditingController? titleController,
    TextEditingController? phoneController,
    TextEditingController? detailsController,
    TextEditingController? linkController,
    double? lat,
    double? long,
    bool? isDefault, //false
    // '+20';
    String? selectedCountryCode,
    Address? address,
  }) {
    return AddressState(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      linkController: linkController ?? this.linkController,
      address: address ?? this.address,
      titleController: titleController ?? this.titleController,
      phoneController: phoneController ?? this.phoneController,
      detailsController: detailsController ?? this.detailsController,
      isDefault: isDefault ?? this.isDefault,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
    );
  }
}
