import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/data/models/notifications_model.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/data/repo/notification_repo.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepo notificationRepo;
  NotificationsCubit(this.notificationRepo)
    : super(NotificationsState.initial());
  List<NotificationItemModel> allNotifications = [];

  Future<void> getNotifications() async {
    // Skip for guests - they don't have notifications
    final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
    print("NotificationsCubit: isGuest=$isGuest");
    
    if (isGuest == true) {
      allNotifications = [];
      if (!isClosed) emit(NotificationsState.success(NotificationsModel(response: [])));
      return;
    }
    
    if(!isClosed) emit(NotificationsState.loading());
    try {
      final response = await notificationRepo.getNotification();
      if(isClosed) return;
      response.when(
        success: (notificationRes) {
          allNotifications = notificationRes.response;
          if(!isClosed) emit(NotificationsState.success(notificationRes));
        },
        failure: (error) {
           if(!isClosed) emit(NotificationsState.fail(error));
        },
      );
    } catch (e) {
      if(!isClosed) emit(NotificationsState.fail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> createNotification({required Map<String, dynamic> body}) async {
    if(!isClosed) emit(NotificationsState.createLoading());
    try {
      final response = await notificationRepo.createNotfication(body: body);
      if(isClosed) return;
      response.when(
        success: (notificationRes) {
          if(!isClosed) emit(NotificationsState.createSuccess(notificationRes));
        },
        failure: (error) {
           if(!isClosed) emit(NotificationsState.createFail(error));
        },
      );
    } catch (e) {
      if(!isClosed) emit(NotificationsState.createFail(ApiErrorHandler.handle(e)));
    }
  }
}
