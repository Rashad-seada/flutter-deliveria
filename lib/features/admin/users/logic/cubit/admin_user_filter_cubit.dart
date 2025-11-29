import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUserFilterCubit extends Cubit<AdminUserFilterState> {
  AdminUserFilterCubit() : super(AdminUserFilterState(selectedVal: 0));
  void updateSelectedVal({required int newVal}) {
    emit(state.copyWith(selectedVal: newVal));
  }
}
