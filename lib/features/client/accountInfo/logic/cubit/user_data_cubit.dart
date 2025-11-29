import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/client/accountInfo/data/repo/get_data_repo.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final GetDataRepo getDataRepo;
  UserDataCubit(this.getDataRepo) : super(UserDataState.initial());
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  void getUserData() async {
    emit(UserDataState.loading());
    try {
      final response = await getDataRepo.getUserData();
      response.when(
        success: (userData) {
          firstName = userData.user?.firstName??"deliveria";
          lastName = userData.user?.lastName??" user ";
          email = userData.user?.email??"deliveriaUser@gmail.com";
          phone = userData.user?.phone??"";
          emit(UserDataState.success(userData));
        },
        failure: (error) => emit(UserDataState.fail(error)),
      );
    } catch (e) {
      emit(UserDataState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void updateUserData({required Map<String, dynamic> body}) async {
    emit(UserDataState.updateLoading());
    try {
      final response = await getDataRepo.updateUserInfo(body: body);
      response.when(
        success: (createRes) {
          emit(UserDataState.updateSuccess(createRes));
        },
        failure: (error) => emit(UserDataState.fail(error)),
      );
    } catch (e) {
      emit(UserDataState.updateFail(ApiErrorHandler.handle(e)));
    }
  }
}
