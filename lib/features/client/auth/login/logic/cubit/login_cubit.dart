import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/client/auth/login/data/models/login_request.dart';
import 'package:delveria/features/client/auth/login/data/repo/login_repo.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginState.initial());
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  String? userName;
  String? userType;
  String? resturantId;
  String? addressId;

  bool emptyFields() {
    if (phone.text.isNullOrEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  void login(LoginRequestBody loginBody) async {
    emit(LoginState.loading());
    final response = await loginRepo.login(loginBody);
    response.when(
      success: (loginData) async {
        if (loginData.message.contains("invalid")) {
          emit(
            LoginState.fail(
              ApiErrorModel(success: false, message: loginData.message),
            ),
          );
        } else if (loginData.user?.ban == true) {
          emit(
            LoginState.fail(
              ApiErrorModel(
                success: false,
                message: AppStrings.userBannedMessage.tr(),
              ),
            ),
          );
        } else if (loginData.agent?.ban == true) {
          // The bug: this branch does not emit a state, so the UI is stuck.
          emit(
            LoginState.fail(
              ApiErrorModel(
                success: false,
                message: AppStrings.userBannedMessage.tr(),
              ),
            ),
          );
        } else {
          await saveUserToken(loginData.token);
          addressId = loginData.user?.addressId ?? "";
          // Save user phone for both user and agent
          String? phoneToSave = loginData.user?.phone ?? loginData.agent?.phone;
          SharedPrefHelper.setData(SharedPrefKeys.userPhone, phoneToSave);
          SharedPrefHelper.setData(SharedPrefKeys.userType, loginData.userType);

          // Save userName for both user and agent
          String userNameToSave = "";
          if (loginData.user != null) {
            userNameToSave =
                (loginData.user?.firstName ?? "") +
                (loginData.user?.lastName ?? "");
          } else if (loginData.agent != null) {
            userNameToSave = loginData.agent?.name ?? "";
          }
          SharedPrefHelper.setData("userName", userNameToSave);

          userType = loginData.userType;
          resturantId = loginData.restaurant?.id;

          // Save resturant id in SharedPref using SharedPrefHelper
          if (resturantId != null) {
            await SharedPrefHelper.setData(SharedPrefKeys.resId, resturantId!);
          }
          print("Success");
          emit(LoginState.success(loginData));
        }
      },
      failure: (error) {
        emit(LoginState.fail(error));
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
  }
}
