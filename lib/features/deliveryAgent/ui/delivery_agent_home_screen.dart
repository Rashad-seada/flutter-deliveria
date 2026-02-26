import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/new_orders_tab_body.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/orders_tab_body.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/client/settings/ui/language_selection_dialog.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:delveria/features/deliveryAgent/ui/widgets/delivery_filter_bottom_sheet.dart';

class DeliveryAgentHomeScreen extends StatefulWidget {
  const DeliveryAgentHomeScreen({super.key});

  @override
  State<DeliveryAgentHomeScreen> createState() =>
      _DeliveryAgentHomeScreenState();
}

class _DeliveryAgentHomeScreenState extends State<DeliveryAgentHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  FilterData _availableOrdersFilter = FilterData();
  FilterData _myOrdersFilter = FilterData();

  // Add a key to force rebuild of TabBarView when refresh is pressed
  Key _tabBarViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _logout(BuildContext context) async {
    await SharedPrefHelper.removeData(SharedPrefKeys.userToken);
    await SharedPrefHelper.clearAllSecuredData();
    context.pushNamedAndRemoveUntil(
      Routes.loginScreen,
      predicate: (route) => false,
    );
  }

  void _fetchData() {
    if (_tabController.index == 0) {
      context.read<AgentOrdersCubit>().getCurrentOrdersAgent(
        date: _availableOrdersFilter.date,
        startDate: _availableOrdersFilter.startDate,
        endDate: _availableOrdersFilter.endDate,
        paymentType: _availableOrdersFilter.paymentType,
        orderType: _availableOrdersFilter.orderType,
      );
    } else {
      context.read<AgentOrdersCubit>().getAcceptedOrders(
        status: _myOrdersFilter.status,
        date: _myOrdersFilter.date,
        startDate: _myOrdersFilter.startDate,
        endDate: _myOrdersFilter.endDate,
        paymentType: _myOrdersFilter.paymentType,
      );
    }
  }

  void _refreshOrders(BuildContext context) {
    _fetchData();
    // Optionally, force TabBarView to rebuild if needed
    setState(() {
      _tabBarViewKey = UniqueKey();
    });
  }

  void _showFilterBottomSheet() {
    final isAvailableTab = _tabController.index == 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DeliveryFilterBottomSheet(
        isAvailableOrdersTab: isAvailableTab,
        initialFilters: isAvailableTab ? _availableOrdersFilter : _myOrdersFilter,
        onApply: (data) {
          setState(() {
            if (isAvailableTab) {
              _availableOrdersFilter = data;
            } else {
              _myOrdersFilter = data;
            }
          });
          _fetchData();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AgentOrdersCubit>()..getCurrentOrdersAgent(),
      child: BlocBuilder<AgentOrdersCubit, AgentOrdersState>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  AppStrings.agentPanal.tr(),
                  style: TextStyles.bimini16W700.copyWith(
                    color: AppColors.primaryDeafult,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LanguageSelectionDialog();
                      },
                    );
                  },
                  child: Icon(Icons.language, color: AppColors.primaryDeafult),
                ),
                actions:
                    state is GetAcceptOrderLoading
                        ? [CustomLoading()]
                        : [
                          IconButton(
                            onPressed: _showFilterBottomSheet,
                            icon: Icon(
                              Icons.filter_list,
                              color: AppColors.primaryDeafult,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _refreshOrders(context);
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: AppColors.primaryDeafult,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.logout, color: Colors.red[800]),
                            tooltip: AppStrings.logOut.tr(),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppStrings.areYouSure.tr(),
                                          style: TextStyles.bimini16W700
                                              .copyWith(
                                                color: AppColors.primaryDeafult,
                                              ),
                                        ),
                                        verticalSpace(20),
                                        TrackOrderButtonRow(
                                          ftitle: AppStrings.logOut.tr(),
                                          sTitle: AppStrings.cancel.tr(),
                                          sOnPressed: () {
                                            context.pop();
                                          },
                                          fOnPressed: () async {
                                            await _logout(context);
                                          },
                                          fWidth: 130.w,
                                          sWidth: 90.w,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
              ),
              body: Column(
                children: [
                  verticalSpace(20),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.red[800],
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: TextStyles.bimini14W500.copyWith(
                      color: AppColors.primaryDeafult,
                    ),
                    unselectedLabelStyle: TextStyles.bimini14W500.copyWith(
                      color: AppColors.darkGrey,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsetsGeometry.symmetric(
                      horizontal: 25.w,
                    ),
                    indicatorColor: Colors.red[800],
                    indicatorWeight: 2,
                    dividerColor: AppColors.grey.withValues(alpha: .4),
                    tabs: [
                      Tab(text: AppStrings.comingOrders.tr()),
                      Tab(text: AppStrings.currentOrders.tr()),
                    ],
                    onTap: (index) {
                      // When switching tabs, fetch the relevant data with saved filters
                      _fetchData();
                      
                      setState(() {
                        _tabBarViewKey = UniqueKey();
                      });
                    },
                  ),
                  Expanded(
                    child: TabBarView(
                      key: _tabBarViewKey,
                      controller: _tabController,
                      children: [
                        NewOrdersTapBody(isDeliveryAgent: true),
                        OrdersTabBody(isDeliveryAgent: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
