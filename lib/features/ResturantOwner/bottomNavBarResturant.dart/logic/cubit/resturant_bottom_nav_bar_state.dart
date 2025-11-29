class ResturantBottomNavBarState {
  final int selectedIndex;

  ResturantBottomNavBarState({required this.selectedIndex});
  ResturantBottomNavBarState copyWith({int? selectedIndex}) {
    return ResturantBottomNavBarState(selectedIndex: selectedIndex??this.selectedIndex);
  }
}
