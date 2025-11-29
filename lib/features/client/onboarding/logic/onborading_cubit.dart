import 'package:carousel_slider/carousel_controller.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboradingCubit extends Cubit<OnboradingState> {
  final CarouselSliderController carouselController = CarouselSliderController();

  OnboradingCubit()
      : super(OnboradingState(pageController: PageController(), currentPage: 0));

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }


  @override
  Future<void> close() {
    state.pageController.dispose();
    return super.close();
  }
}
