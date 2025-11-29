import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResturantBottomNavBarCubit extends Cubit<ResturantBottomNavBarState> {
  ResturantBottomNavBarCubit()
    : super(ResturantBottomNavBarState(selectedIndex: 0));
  void updateSelectedIndex(int newIndex) {
    emit(state.copyWith(selectedIndex: newIndex));
  }
}
