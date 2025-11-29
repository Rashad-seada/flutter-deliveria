import 'package:carousel_slider/carousel_controller.dart';

class CarouselState {
  final CarouselSliderController carouselSliderController;
  final int currentPage;
  final int selectedIndex;
  final int selectedval;

  CarouselState( {
    required this.carouselSliderController,
    required this.currentPage,
    required this.selectedIndex,
    required this.selectedval,
  });

  CarouselState copyWith({
    int? currentPage,
    CarouselSliderController? carouselSliderController,
    int? selectedIndex,
    int? selectedval
  }) {
    return CarouselState(
      carouselSliderController:
          carouselSliderController ?? this.carouselSliderController,
      currentPage: currentPage ?? this.currentPage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedval: selectedval??this.selectedval
    );
  }
}
