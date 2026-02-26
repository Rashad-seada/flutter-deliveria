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
    if (isClosed) return;
    emit(GetAllUsersAdminState.loading());
    try {
      final response = await getUsersRepo.getAllUsers();
      if (isClosed) return;
      response.when(
        success: (usersRes) {
          users = usersRes.users;
          if (!isClosed) emit(GetAllUsersAdminState.success(usersRes));
        },
        failure: (error) {
          if (!isClosed) emit(GetAllUsersAdminState.fail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(GetAllUsersAdminState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void banUser({required String userId}) async {
    if (isClosed) return;
    emit(GetAllUsersAdminState.banLoading());
    try {
      final response = await getUsersRepo.banUser(userId: userId);
      if (isClosed) return;
      response.when(
        success: (usersRes) {
          getAllUsers();
          if (!isClosed) emit(GetAllUsersAdminState.banSuccess(usersRes));
        },
        failure: (error) {
          if (!isClosed) emit(GetAllUsersAdminState.banFail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(GetAllUsersAdminState.banFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> searchUser({required String query}) async {
    if (isClosed) return;
    emit(GetAllUsersAdminState.searchUserLoading());
    try {
      final response = await getUsersRepo.searchUser(query: query);
      if (isClosed) return;
      response.when(
        success: (usersRes) {
          searchUsers = usersRes.users;
          print("❤️‍🔥 $searchUsers");
          if (!isClosed) emit(GetAllUsersAdminState.searchUserSuccess(usersRes));
        },
        failure: (error) {
          if (!isClosed) emit(GetAllUsersAdminState.searchUserFail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(GetAllUsersAdminState.searchUserFail(ApiErrorHandler.handle(e)));
    }
  }
}
