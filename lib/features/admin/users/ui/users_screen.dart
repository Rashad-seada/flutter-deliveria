import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_state.dart'
    as notifi;
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/circular_chart.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_cubit.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_state.dart';
import 'package:delveria/features/admin/users/ui/widgets/user_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({
    super.key,
    this.isFromNotification,
    this.message,
    this.selectedIds,
  });
  final bool? isFromNotification;
  final String? message;
  final List<String>? selectedIds;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<bool> isSelectedList = [];
  String searchQury = "";
  bool sendToAll = false;

  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  List<String> _getAllUserIds(List users) {
    return users
        .map<String>((e) {
          // e is UserModelAdmin
          if (e is Map && e.containsKey('id')) return e['id'].toString();
          if (e is Map && e.containsKey('_id')) return e['_id'].toString();
          if (e.id != null) return e.id.toString();
          return '';
        })
        .where((id) => id.isNotEmpty)
        .toList();
  }

  void _sendNotificationToUsers({
    required String message,
    required List<String> ids,
  }) {
    final cubit = context.read<NotificationsCubit>();
    cubit.createNotification(body: {"message": message, "ids": ids});
  }

  Future<void> _handleRefresh() async {
    await context.read<GetAllUsersAdminCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<GetAllUsersAdminCubit, GetAllUsersAdminState>(
          builder: (context, state) {
            if (state is Loading) {
              return CustomLoading();
            }
            final cubit = context.read<GetAllUsersAdminCubit>();
            final users =
                searchQury.trim().isNotEmpty ? cubit.searchUsers : cubit.users;

            // If not in notification mode, set isSelectedList based on user.ban
            if (widget.isFromNotification == true) {
              if (isSelectedList.length != users.length) {
                isSelectedList = List.generate(users.length, (i) => false);
              }
            } else {
              // In users mode, set isSelectedList based on user.ban
              isSelectedList = List.generate(users.length, (i) {
                final user = users[i];
                // user is UserModelAdmin
                if (user is Map) {
                  return user.ban == true;
                } else
                  return user.ban == true;
              });
            }

            final bool isSearching = searchQury.trim().isNotEmpty;

            return BlocListener<NotificationsCubit, notifi.NotificationsState>(
              listener: (context, state) {
                state.whenOrNull(
                  createSuccess: (data) {
                    showSuccessSnackBar(
                      context,
                      "notificationsendsuccessfully".tr(),
                    );
                  },
                );
              },
              child: Column(
                children: [
                  verticalSpace(20),
                  SearchRow(
                    hint: "searchbyuserphone".tr(),
                    showButton: false,
                    dontShowFilter: true,
                    showIosArrow: false,
                    isAdmin: false,
                    isAdminUser: false,
                    onChanged: (p0) async {
                      setState(() {
                        searchQury = p0;
                      });
                      await cubit.searchUser(query: p0);
                    },
                  ),
                  verticalSpace(10),
                  Expanded(
                    child: RefreshIndicator(
                      key: _refreshKey,
                      onRefresh: _handleRefresh,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.sqaureIcon,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  AppStrings.usersList.tr(),
                                  style: TextStyles.bimini20W700,
                                ),
                                Spacer(),
                                CircularChart(
                                  totalNumbers: users.length,
                                  progress:
                                      users.isEmpty
                                          ? 0
                                          : users.length.toDouble() / 100,
                                ),
                              ],
                            ),
                            widget.isFromNotification == true
                                ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.sendToAll.tr(),
                                      style: TextStyles.bimini16W700,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sendToAll = !sendToAll;
                                        });
                                        final message =
                                            widget.message ?? "test";
                                        if (sendToAll) {
                                          final ids = _getAllUserIds(users);
                                          if (ids.isNotEmpty) {
                                            _sendNotificationToUsers(
                                              message: message,
                                              ids: ids,
                                            );
                                          }
                                        } else if (widget.selectedIds != null &&
                                            widget.selectedIds!.isNotEmpty) {
                                          _sendNotificationToUsers(
                                            message: message,
                                            ids: widget.selectedIds!,
                                          );
                                        } else {
                                          showWarningSnackBar(
                                            context,
                                            'pleaseSelectUserOrSendToAll'.tr(),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: 32.w,
                                        height: 32.h,
                                        decoration: BoxDecoration(
                                          color:
                                              sendToAll
                                                  ? AppColors.primaryDeafult
                                                      .withOpacity(0.2)
                                                  : AppColors.lightGrey,
                                          border: Border.all(
                                            color: Colors.black.withOpacity(.3),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child:
                                            sendToAll
                                                ? Icon(
                                                  Icons.check,
                                                  color:
                                                      AppColors.primaryDeafult,
                                                  size: 20,
                                                )
                                                : null,
                                      ),
                                    ),
                                  ],
                                )
                                : SizedBox(),

                            const SizedBox(height: 24),
                            if (users.isEmpty)
                              Center(
                                child: Text(
                                  isSearching
                                      ? "noUsersFoundForSearch".tr()
                                      : "noUsersAvailable".tr(),
                                  style: TextStyles.bimini16W700,
                                ),
                              )
                            else
                              ...users.asMap().entries.map((entry) {
                                final i = entry.key;
                                final e = entry.value;

                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24.h),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (widget.isFromNotification ==
                                              true) {
                                            final user = users[entry.key];
                                            String? id;

                                            // user is UserModelAdmin
                                            id = user.id.toString();

                                            if (id.isNotEmpty) {
                                              _sendNotificationToUsers(
                                                message:
                                                    widget.message ?? "test",
                                                ids: [id],
                                              );
                                            }
                                          }
                                        },
                                        child: UserCard(
                                          index: i,
                                          isSelected: isSelectedList,
                                          onCheckTap: () {
                                            setState(() {
                                              // In notification mode, toggle selection as before
                                              if (widget.isFromNotification ==
                                                  true) {
                                                isSelectedList[i] =
                                                    !isSelectedList[i];
                                              } else {
                                                cubit.banUser(userId: e.id);
                                                isSelectedList[i] =
                                                    !(isSelectedList[i]);
                                              }
                                            });
                                            if (widget.isFromNotification ==
                                                true) {
                                              final user = users[entry.key];
                                              String? id;
                                              id = user.id.toString();
                                              if (id.isNotEmpty) {
                                                _sendNotificationToUsers(
                                                  message:
                                                      widget.message ?? "test",
                                                  ids: [id],
                                                );
                                              }
                                            }
                                          },
                                          name: "${e.firstName} ${e.lastName}",
                                          email: e.email,
                                          order: e.numberOfOrders.toString(),
                                          phone: e.phone,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (
            BuildContext context,
            GetAllUsersAdminState<dynamic> state,
          ) {
            if (state is BanSuccess) {
              showSuccessSnackBar(
                context,
                AppStrings.userBannedUnbannedSuccess.tr(),
              );
            }
          },
        ),
      ),
    );
  }
}
