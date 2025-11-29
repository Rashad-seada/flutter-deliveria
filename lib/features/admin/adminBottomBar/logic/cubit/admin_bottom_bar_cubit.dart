import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBottomBarCubit extends Cubit<AdminBottomBarState> {
  AdminBottomBarCubit() : super(AdminBottomBarState(selectedIndex: 0));

  void updateSelectedIndex(int newIndex) {
    emit(state.copyWith(selectedIndex: newIndex));
  }
}
