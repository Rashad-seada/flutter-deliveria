import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResturantMenuCubit extends Cubit<ResturantMenuState> {
  ResturantMenuCubit()
    : super(
        ResturantMenuState(
          toggleToHorizental: false,
          selectedVal: 0,
          selectedSize: 'Medium',
          selectedTopping: 'Special burger sauce',
          customizationController: TextEditingController(),
        ),
      );

  void makeMenuHorizental() {
    emit(state.copyWith(toggleToHorizental: !state.toggleToHorizental));
  }
  void updateSelectedVal({required int newVal}) {
    emit(state.copyWith(selectedVal: newVal));
  }
  void updateSelectedSize({required String newselectedSize}) {
    emit(state.copyWith(selectedSize: newselectedSize));
  }
  void updateSelectedTopping({required String newSelectedTopping}) {
    emit(state.copyWith(selectedTopping: newSelectedTopping));
  }
  @override
  Future<void> close() {
   state. customizationController.dispose();
    return super.close();
  }
}
