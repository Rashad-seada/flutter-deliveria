import 'package:delveria/core/network/api_error_handler.dart';
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
    emit(NotificationsState.loading());
    try {
      final response = await notificationRepo.getNotification();
      response.when(
        success: (notificationRes) {
          allNotifications = notificationRes.response;
          emit(NotificationsState.success(notificationRes));
        },
        failure: (error) => emit(NotificationsState.fail(error)),
      );
    } catch (e) {
      emit(NotificationsState.fail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> createNotification({required Map<String, dynamic> body}) async {
    emit(NotificationsState.createLoading());
    try {
      final response = await notificationRepo.createNotfication(body: body);
      response.when(
        success: (notificationRes) {
          emit(NotificationsState.createSuccess(notificationRes));
        },
        failure: (error) => emit(NotificationsState.createFail(error)),
      );
    } catch (e) {
      emit(NotificationsState.createFail(ApiErrorHandler.handle(e)));
    }
  }
}
