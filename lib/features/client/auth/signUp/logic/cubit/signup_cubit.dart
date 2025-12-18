import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/network/api_error_model.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/client/auth/signUp/data/models/sign_up_request_body.dart';
import 'package:delveria/features/client/auth/signUp/data/repo/sign_up_repo.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignUpRepo signUpRepo;
  SignupCubit(this.signUpRepo) : super(SignupState.initial());
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool empyFields() {
    if (firstName.text.isNullOrEmpty() ||
        lastName.text.isNullOrEmpty() ||
        password.text.isNullOrEmpty() ||
        phone.text.isNullOrEmpty() ) {
      return true;
    } else {
      return false;
    }
  }

  void signUp(SignUpRequestBody signUpRequestBody) async {
    emit(SignupState.loading());
    final response = await signUpRepo.signUp(signUpRequestBody);
    response.when(
      success: (signUpResponse) {
        if (signUpResponse.success == false) {
          emit(
            SignupState.fail(
              ApiErrorModel(success: false, message: signUpResponse.message),
            ),
          );
        } else {

          emit(SignupState.success(signUpResponse));
        }
      },
      failure: (error) => emit(SignupState.fail(error)),
    );
  }
  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
  }
}
