import 'package:delveria/core/network/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'notifications_state.freezed.dart';

@freezed
class NotificationsState<T> with _$NotificationsState {
  const factory NotificationsState.initial() = _Initial;
  const factory NotificationsState.loading() = Loading;
  const factory NotificationsState.success(T data) = Success<T>;
  const factory NotificationsState.fail(ApiErrorModel error) = Fail;
  const factory NotificationsState.createLoading() = CreateLoading;
  const factory NotificationsState.createSuccess(T data) = CreateSuccess<T>;
  const factory NotificationsState.createFail(ApiErrorModel error) = CreateFail;
}
