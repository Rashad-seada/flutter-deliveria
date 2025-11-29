import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/resturant_admin_screen.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_cubit.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_cubit.dart';
import 'package:delveria/features/admin/users/ui/users_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void pushNotification(
  BuildContext context,
  TextEditingController messageController,
  bool isUser,
) {
  if (messageController.text.trim().isNotEmpty) {
    if (isUser) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<AdminUserFilterCubit>(),
                  ),
                  BlocProvider(
                    create:
                        (context) =>
                            getIt<GetAllUsersAdminCubit>()..getAllUsers(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<NotificationsCubit>(),
                  ),
                ],
                child: UsersScreen(
                  isFromNotification: true,
                  message: messageController.text,
                ),
              ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<AdminResturantFilterCubit>(),
                  ),
                  BlocProvider(
                    create:
                        (context) =>
                            getIt<AllresturantsadminCubit>()
                              ..getAllResturantsForAdmin(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<NotificationsCubit>()
                              
                  ),
                ],
                child: ResturantAdminScreen(
                  isFromNotification: true,
                  message: messageController.text,
                ),
              ),
        ),
      );
    }
  } else {
    showWarningSnackBar(context, "writeMessage".tr());
  }
}
