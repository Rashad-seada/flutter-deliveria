

import 'package:carousel_slider/carousel_controller.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(CarouselState(
    selectedval: 0,
    carouselSliderController: CarouselSliderController() , currentPage: 0, selectedIndex: 0
    
  ));
    void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }
    void updateSelectedIndex(int newIndex) {
    emit(state.copyWith(selectedIndex: newIndex));
  }
    void updateSelectedVal(int newVal) {
    emit(state.copyWith(selectedval: newVal));
  }
}
