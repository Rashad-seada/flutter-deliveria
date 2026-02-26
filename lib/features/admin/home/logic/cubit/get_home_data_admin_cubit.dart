import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/admin/home/data/repo/get_home_data_repo.dart';
import 'package:delveria/features/admin/home/logic/cubit/get_home_data_admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetHomeDataAdminCubit extends Cubit<GetHomeDataAdminState> {
  final GetHomeDataRepo getHomeDataRepo;
  GetHomeDataAdminCubit(this.getHomeDataRepo) : super(GetHomeDataAdminState.initial());

  int? ordersNumber;
  num? netRevenue;
  int? activeUsers;
  int? activeRestaurants;
  num? totalAmount;
  int? ordersToday;
  List<int>? ordersOfLastWeek;

  void getHomeDataAdmin() async {
    if (isClosed) return;
    emit(GetHomeDataAdminState.loading());
    try {

      final response = await getHomeDataRepo.getHomeDataAdmin();
      if (isClosed) return;
      response.when(
        success: (resDataHome) async {
          ordersNumber = resDataHome.totalOrders;
          netRevenue = resDataHome.netRevenue;
          activeUsers = resDataHome.activeUsers;
          activeRestaurants = resDataHome.activeRestaurants;
          totalAmount = resDataHome.totalAmount;
          ordersToday = resDataHome.ordersToday;
          ordersOfLastWeek = resDataHome.ordersOfLastWeek;
          if (!isClosed) emit(GetHomeDataAdminState.success(resDataHome));
        },
        failure: (error) {
          if (!isClosed) emit(GetHomeDataAdminState.fail(error));
        },
      );
    } catch (e) {
      if (!isClosed) emit(GetHomeDataAdminState.fail(ApiErrorHandler.handle(e)));
    }
  }
}
