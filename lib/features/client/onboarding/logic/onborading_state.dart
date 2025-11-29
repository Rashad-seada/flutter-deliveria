import 'package:flutter/widgets.dart';

class OnboradingState {
  final PageController pageController;
  final int currentPage;

  OnboradingState({required this.pageController, required this.currentPage});

  OnboradingState copyWith({int? currentPage, PageController? pageController}) {
    return OnboradingState(
      pageController: pageController ?? this.pageController,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
