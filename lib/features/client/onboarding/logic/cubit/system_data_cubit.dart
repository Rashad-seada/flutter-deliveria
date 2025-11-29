import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/onboarding/data/repo/get_system_data_repo.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemDataCubit extends Cubit<SystemDataState> {
  final GetSystemDataRepo getSystemDataRepo;
  SystemDataCubit(this.getSystemDataRepo) : super(SystemDataState.initial());
  bool? isUploaded;
  void getSystemData() async {
    emit(SystemDataState.loading());
    try {
      final result = await getSystemDataRepo.getSystemData();
      result.when(
        success: (data) {
          isUploaded = data.response?.isUploaded;
          emit(SystemDataState.success());
        },
        failure: (error) => emit(SystemDataState.fail(error)),
      );
    } catch (e) {
      emit(SystemDataState.fail(ApiErrorHandler.handle(e)));
    }
  }
}
