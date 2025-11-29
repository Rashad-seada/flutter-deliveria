import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/admin/users/data/models/get_all_users_model.dart';
import 'package:delveria/features/admin/users/data/repo/get_users_repo.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllUsersAdminCubit extends Cubit<GetAllUsersAdminState> {
  final GetUsersRepo getUsersRepo;
  GetAllUsersAdminCubit(this.getUsersRepo)
    : super(GetAllUsersAdminState.initial());
  List<UserModelAdmin> users = [];
  List<UserModelAdmin> searchUsers = [];

  Future<void> getAllUsers() async {
    emit(GetAllUsersAdminState.loading());
    try {
      final response = await getUsersRepo.getAllUsers();
      response.when(
        success: (usersRes) {
          users = usersRes.users;
          emit(GetAllUsersAdminState.success(usersRes));
        },
        failure: (error) => emit(GetAllUsersAdminState.fail(error)),
      );
    } catch (e) {
      emit(GetAllUsersAdminState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void banUser({required String userId}) async {
    emit(GetAllUsersAdminState.banLoading());
    try {
      final response = await getUsersRepo.banUser(userId: userId);
      response.when(
        success: (usersRes) {
          getAllUsers();
          emit(GetAllUsersAdminState.banSuccess(usersRes));
        },
        failure: (error) => emit(GetAllUsersAdminState.banFail(error)),
      );
    } catch (e) {
      emit(GetAllUsersAdminState.banFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> searchUser({required String query}) async {
    emit(GetAllUsersAdminState.searchUserLoading());
    try {
      final response = await getUsersRepo.searchUser(query: query);
      response.when(
        success: (usersRes) {
          searchUsers = usersRes.users;
          print("❤️‍🔥 $searchUsers");
          emit(GetAllUsersAdminState.searchUserSuccess(usersRes));
        },
        failure: (error) => emit(GetAllUsersAdminState.searchUserFail(error)),
      );
    } catch (e) {
      emit(GetAllUsersAdminState.searchUserFail(ApiErrorHandler.handle(e)));
    }
  }
}
