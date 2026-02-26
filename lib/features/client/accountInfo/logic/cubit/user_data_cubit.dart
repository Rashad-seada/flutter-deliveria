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
    if (!isClosed) emit(UserDataState.loading());
    try {
      final response = await getDataRepo.getUserData();
      if (isClosed) return;
      response.when(
        success: (userData) {
          firstName = userData.user?.firstName??"deliveria";
          lastName = userData.user?.lastName??" user ";
          email = userData.user?.email??"deliveriaUser@gmail.com";
          phone = userData.user?.phone??"";
          if (!isClosed) emit(UserDataState.success(userData));
        },
        failure: (error) {
           if (!isClosed) emit(UserDataState.fail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(UserDataState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void updateUserData({required Map<String, dynamic> body}) async {
    if (!isClosed) emit(UserDataState.updateLoading());
    try {
      final response = await getDataRepo.updateUserInfo(body: body);
      if (isClosed) return;
      response.when(
        success: (createRes) {
          if (!isClosed) emit(UserDataState.updateSuccess(createRes));
        },
        failure: (error) {
          if (!isClosed) emit(UserDataState.fail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(UserDataState.updateFail(ApiErrorHandler.handle(e)));
    }
  }
}
