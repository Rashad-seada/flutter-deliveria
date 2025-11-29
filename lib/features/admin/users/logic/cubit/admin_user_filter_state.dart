class AdminUserFilterState {
  final int selectedVal;

  AdminUserFilterState({required this.selectedVal});
  AdminUserFilterState copyWith({int? selectedVal}) {
    return AdminUserFilterState(selectedVal: selectedVal ?? this.selectedVal);
  }
}
