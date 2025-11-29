class AdminBottomBarState {
  final int selectedIndex;

  AdminBottomBarState({required this.selectedIndex});
  AdminBottomBarState copyWith({int? selectedIndex}) {
    return AdminBottomBarState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
