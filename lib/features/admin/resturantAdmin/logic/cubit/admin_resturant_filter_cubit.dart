import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminResturantFilterCubit extends Cubit<AdminResturantFilterState> {
  AdminResturantFilterCubit()
    : super(AdminResturantFilterState(selectedVal: 0));

  void updateSelected({required int newSelected}) {
    emit(state.copyWith(selectedVal: newSelected));
  }
}
