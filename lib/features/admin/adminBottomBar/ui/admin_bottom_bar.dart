import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_cubit.dart';
import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_state.dart';
import 'package:delveria/features/admin/drawer/ui/admin_drawer.dart';
import 'package:delveria/features/admin/home/logic/cubit/get_home_data_admin_cubit.dart';
import 'package:delveria/features/admin/home/ui/home_admin.dart';
import 'package:delveria/features/admin/home/ui/widgets/admin_bottom_bar_bloc.dart';
import 'package:delveria/features/admin/notificationsAdmin/ui/admin_notification_screen.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/resturant_admin_screen.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_cubit.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_cubit.dart';
import 'package:delveria/features/admin/users/ui/users_screen.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/deliver_to_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({
    super.key,
    required this.selectedIndex,
    required this.isFromNotificationUsers,
    required this.isFromNotificationResturants,
  });
  final int selectedIndex;
  final bool isFromNotificationUsers, isFromNotificationResturants;

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AdminBottomBarCubit>();
    if (cubit.state.selectedIndex != widget.selectedIndex) {
      cubit.updateSelectedIndex(widget.selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<AllresturantsadminCubit>()
              ..getAllRatedResturantsWithoutLocation(),
          ),
          BlocProvider.value(
            value: getIt<GetHomeDataAdminCubit>()..getHomeDataAdmin(),
          ),
        ],
        child: HomeAdmin(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AdminUserFilterCubit>()),
          BlocProvider.value(
            value: getIt<GetAllUsersAdminCubit>()..getAllUsers(),
          ),
          BlocProvider.value(
            value: getIt<NotificationsCubit>(),
          ),
        ],
        child: UsersScreen(isFromNotification: widget.isFromNotificationUsers),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AdminResturantFilterCubit>()),
          BlocProvider.value(
            value: getIt<AllresturantsadminCubit>()
              ..getAllResturantsForAdmin(),
          ),
        ],
        child: ResturantAdminScreen(
          isFromNotification: widget.isFromNotificationResturants,
        ),
      ),
      AdminNotificationsScreen(),
    ];

    return BlocBuilder<AdminBottomBarCubit, AdminBottomBarState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            drawer: const AdminDrawer(),
            appBar:
                state.selectedIndex == 0
                    ? PreferredSize(
                      preferredSize: Size.fromHeight(80),
                      child: BlocProvider(
                        create:
                            (context) =>
                                getIt<CreateAddressCubit>()..getAdresses(),

                        child: DelivertoRow(isAdmin: true),
                      ),
                    )
                    : null,
            body: pages[state.selectedIndex],
            bottomNavigationBar: AdminBottomBarBloc(state: state),
          ),
        );
      },
    );
  }
}
