import 'package:flutter/widgets.dart';

class MenuResturantState {
  final bool toggleToHorizental;
  final TextEditingController customizationController;

  MenuResturantState( {required this.toggleToHorizental, required this.customizationController,
  });

  MenuResturantState copyWith({bool? toggleToHorizental , TextEditingController? customizationController}) {
    return MenuResturantState(
      customizationController: customizationController??this.customizationController,
      toggleToHorizental: toggleToHorizental ?? this.toggleToHorizental,
    );
  }
}
