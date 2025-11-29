import 'package:flutter/material.dart';

class ResturantMenuState {
  final bool toggleToHorizental;
  final int selectedVal;
 final String selectedSize; 
 final String selectedTopping; 
  final TextEditingController customizationController;

  ResturantMenuState({
    required this.toggleToHorizental,
    required this.selectedVal,
    required this.selectedSize,
    required this.selectedTopping,
    required this.customizationController, 

  });

  ResturantMenuState copyWith({bool? toggleToHorizental, int? selectedVal ,  String ? selectedSize, // = 'Medium';
  String? selectedTopping, // = 'Special burger sauce';
   TextEditingController? customizationController }) {
    return ResturantMenuState(
      selectedVal: selectedVal ?? this.selectedVal,
      toggleToHorizental: toggleToHorizental ?? this.toggleToHorizental,
      selectedSize: selectedSize??this.selectedSize, 
      selectedTopping: selectedTopping??this.selectedTopping, 
      customizationController: customizationController??this.customizationController
    );
  }
}
