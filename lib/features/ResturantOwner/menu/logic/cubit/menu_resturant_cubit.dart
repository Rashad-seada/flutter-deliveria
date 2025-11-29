import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuResturantCubit extends Cubit<MenuResturantState> {
  MenuResturantCubit() : super(MenuResturantState(toggleToHorizental: false, customizationController: TextEditingController()));
  void makeHorizental() {
    emit(state.copyWith(toggleToHorizental: !state.toggleToHorizental));
  }
}
