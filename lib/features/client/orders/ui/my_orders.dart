import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/widgets/continue_as_guest_body.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_state.dart';
import 'package:delveria/features/client/orders/ui/widgets/my_orders_app_bar.dart';
import 'package:delveria/features/client/orders/ui/widgets/my_orders_list.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadContinueAsGuest();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
       
        return BlocBuilder<GetOrdersCubit, GetOrdersState>(
          builder: (context, ordersState) {
            if (ordersState is Loading) {
              return Scaffold(body: CustomLoading());
            }
            final cubit = context.read<GetOrdersCubit>();
          
            List<OrderModel> ongoingOrders =
                cubit.orders
                    .where(
                      (e) => !["Delivered", "Completed", "Canceled"].contains(e.status),
                    )
                    .toList();
            List<OrderModel> historyOrders =
                cubit.orders.where((e) => ["Delivered", "Completed", "Canceled"].contains(e.status)).toList();

            // Sort ongoingOrders and historyOrders from newest to oldest
            // Assuming each order has a `createdAt` field of type DateTime, otherwise use appropriate field
            ongoingOrders.sort((a, b) {
              if (a.createdAt == null && b.createdAt == null) return 0;
              if (a.createdAt == null) return 1; // nulls last
              if (b.createdAt == null) return -1;
              return b.createdAt!.compareTo(a.createdAt!); // newest first
            });
            historyOrders.sort((a, b) {
              if (a.createdAt == null && b.createdAt == null) return 0;
              if (a.createdAt == null) return 1; // nulls last
              if (b.createdAt == null) return -1;
              return b.createdAt!.compareTo(a.createdAt!); // newest first
            });

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: MyOrdersAppBar(
                  tabController: _tabController,
                  themeState: state,
                  onRefreshPressed: () {
                    cubit.getOrdersUser();
                  },
                ),
              ),
              body:
                  isContinueAsGuest
                      ? ContinueAsGuestBody()
                      : TabBarView(
                        controller: _tabController,
                        children: [
                          BlocProvider(
                            create: (context) => getIt<GetOrdersCubit>(),
                            child: MyOrdersList(
                              isOngoing: true,
                              themeState: state,
                              orders: ongoingOrders,
                              orderStatus: '',
                            ),
                          ),
                          BlocProvider(
                            create: (context) => getIt<GetOrdersCubit>(),
                            child: MyOrdersList(
                              orderStatus:
                                  historyOrders.isNotEmpty
                                      ? historyOrders.first.status ?? ""
                                      : "",
                              isOngoing: false,
                              themeState: state,
                              orders: historyOrders,
                            ),
                          ),
                        ],
                      ),
            );
          },
        );
      },
    );
  }
}
