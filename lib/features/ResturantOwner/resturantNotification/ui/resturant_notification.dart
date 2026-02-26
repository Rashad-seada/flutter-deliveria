import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/continue_as_guest_body.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_state.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/ui/widgets/notification_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResturantNotification extends StatefulWidget {
  const ResturantNotification({super.key, this.isRestaurant, this.isAdmin});
  final bool? isRestaurant;
  final bool? isAdmin;

  @override
  State<ResturantNotification> createState() => _ResturantNotificationState();
}

class _ResturantNotificationState extends State<ResturantNotification> {
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 10;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) {
      return AppStrings.today.tr();
    } else if (notificationDate == yesterday) {
      return AppStrings.yesterday.tr();
    } else {
      return DateFormat('MMM d, yyyy').format(notificationDate);
    }
  }

  @override
  void initState() {
    super.initState();
    loadContinueAsGuest();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll * 0.9; // Load more when 90% scrolled

    if (currentScroll >= threshold) {
      _loadMoreNotifications();
    }
  }

  void _loadMoreNotifications() {
    final cubit = context.read<NotificationsCubit>();
    final totalNotifications = cubit.allNotifications.length;
    final currentlyDisplayed = _currentPage * _itemsPerPage;

    if (currentlyDisplayed < totalNotifications) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });

      // Simulate loading delay for better UX
      Future.delayed(Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    }
  }

  List<Map<String, dynamic>> _getPaginatedGroupedNotifications(
    List notifications,
  ) {
    // Get notifications for current page
    final endIndex = (_currentPage * _itemsPerPage).clamp(
      0,
      notifications.length,
    );
    final paginatedNotifications = notifications.sublist(0, endIndex);

    // Group notifications by date
    final List<Map<String, dynamic>> groupedNotifications = [];
    String? lastDateLabel;

    for (var notification in paginatedNotifications) {
      final createdAt = DateTime.tryParse(notification.createdAt ?? "");
      if (createdAt == null) continue;
      final dateLabel = _getDateLabel(createdAt);

      if (lastDateLabel != dateLabel) {
        groupedNotifications.add({'type': 'separator', 'label': dateLabel});
        lastDateLabel = dateLabel;
      }
      groupedNotifications.add({
        'type': 'notification',
        'notification': notification,
      });
    }

    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop:
              widget.isRestaurant == true || widget.isAdmin == true
                  ? true
                  : false,
          showTitle: true,
          title: AppStrings.notifications.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body:
          widget.isRestaurant == false && isContinueAsGuest == true
              ? ContinueAsGuestBody()
              : BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return CustomLoading();
                  }
                  final cubit = context.read<NotificationsCubit>();
                  final notifications = List.of(cubit.allNotifications);

                  if (notifications.isEmpty) {
                    return Center(
                      child: Text(
                        'No notifications',
                        style: TextStyles.bimini20W700,
                      ),
                    );
                  }

                  // Sort notifications from newest to oldest
                  notifications.sort((a, b) {
                    final aDate =
                        DateTime.tryParse(a.createdAt ?? "") ?? DateTime(1970);
                    final bDate =
                        DateTime.tryParse(b.createdAt ?? "") ?? DateTime(1970);
                    return bDate.compareTo(aDate);
                  });

                  final groupedNotifications =
                      _getPaginatedGroupedNotifications(notifications);
                  final hasMoreItems =
                      (_currentPage * _itemsPerPage) < notifications.length;

                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16),
                    itemCount:
                        groupedNotifications.length +
                        (hasMoreItems || _isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Loading indicator at the end
                      if (index == groupedNotifications.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryDeafult,
                            ),
                          ),
                        );
                      }

                      final item = groupedNotifications[index];
                      if (item['type'] == 'separator') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index > 0) verticalSpace(20),
                            Text(item['label'], style: TextStyles.bimini20W700),
                            verticalSpace(30),
                          ],
                        );
                      } else if (item['type'] == 'notification') {
                        final notification = item['notification'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(10),
                            NotificationItem(
                              name: notification.senderName ?? "Deliveria",
                              action: notification.message ?? "",
                              time: formatDate(notification.createdAt),
                            ),
                            verticalSpace(10),
                            Divider(),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
    );
  }
}
