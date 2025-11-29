class AdminResturantFilterState {
  final int selectedVal;

  AdminResturantFilterState({required this.selectedVal});

  AdminResturantFilterState copyWith({int ? selectedVal }){
    return AdminResturantFilterState(selectedVal: selectedVal??this.selectedVal);
  }
}
