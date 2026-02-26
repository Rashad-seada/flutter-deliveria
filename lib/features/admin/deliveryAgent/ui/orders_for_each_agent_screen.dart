import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/date_formate.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_state.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/order_details_agent.dart';
import 'package:delveria/features/client/orders/ui/widgets/my_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersForEachAgentScreen extends StatefulWidget {
  const OrdersForEachAgentScreen({super.key, required this.id});
  final String id;

  @override
  State<OrdersForEachAgentScreen> createState() =>
      _OrdersForEachAgentScreenState();
}

class _OrdersForEachAgentScreenState extends State<OrdersForEachAgentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Only for completed tab
  DateTime? _completedFromDate;
  DateTime? _completedToDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // To update the filter icon visibility
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _showDateRangeFilterDialog() async {
    DateTime? fromDate = _completedFromDate;
    DateTime? toDate = _completedToDate;

    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      initialDateRange:
          (fromDate != null && toDate != null)
              ? DateTimeRange(start: fromDate, end: toDate)
              : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryDeafult,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _completedFromDate = DateTime(
          picked.start.year,
          picked.start.month,
          picked.start.day,
        );
        _completedToDate = DateTime(
          picked.end.year,
          picked.end.month,
          picked.end.day,
        );
      });
    }
  }

  void _clearDateRange() {
    setState(() {
      _completedFromDate = null;
      _completedToDate = null;
    });
  }

  // Only compare the date part (ignore hours/minutes/seconds)
  bool _isWithinRange(DateTime date, DateTime? from, DateTime? to) {
    if (from == null || to == null) return true;
    final dateOnly = DateTime(date.year, date.month, date.day);
    final fromOnly = DateTime(from.year, from.month, from.day);
    final toOnly = DateTime(to.year, to.month, to.day);
    return !dateOnly.isBefore(fromOnly) && !dateOnly.isAfter(toOnly);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentsCubit, AgentsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            toolbarHeight: 40,
            leading: IconButton(
              icon: Icon(Icons.refresh, color: AppColors.primaryDeafult),
              onPressed: () {
                final status = _tabController.index == 0 ? 'active' : 'history';
                context.read<AgentsCubit>().getAllOrdersEachAgent(widget.id, status: status);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: BlocBuilder<AgentsCubit, AgentsState>(
            builder: (context, state) {
              final cubit = context.read<AgentsCubit>();

              if (state is GetAllOrdersEachAgentLoading) {
                return CustomLoading();
              } else if (state is GetAllOrdersEachAgentFail) {
                return Center(child: Text('Failed to load orders'));
              } else if (state is GetAllOrdersEachAgentSuccess) {
                final orders = cubit.agentOrders ?? [];

                final ongoingOrders =
                    orders
                        .where(
                          (order) =>
                              order.status != "Completed" &&
                              order.status != "Canceled",
                        )
                        .toList();
                final completedOrders =
                    orders
                        .where(
                          (order) =>
                              order.status == "Completed" ||
                              order.status == "Canceled",
                        )
                        .toList();

                // Only filter completed orders by date range
                final filteredOngoingOrders = ongoingOrders;

                final filteredCompletedOrders =
                    (_completedFromDate == null || _completedToDate == null)
                        ? completedOrders
                        : completedOrders.where((order) {
                          final orderDate = DateTime.tryParse(order.createdAt);
                          if (orderDate == null) return false;
                          return _isWithinRange(
                            orderDate,
                            _completedFromDate,
                            _completedToDate,
                          );
                        }).toList();

                return Column(
                  children: [
                    verticalSpace(10),
                    // Only show filter icon for completed tab
                    if (_tabController.index == 1)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              _showDateRangeFilterDialog();
                            },
                            child: Icon(
                              Icons.filter_alt_rounded,
                              color: AppColors.primaryDeafult,
                            ),
                          ),
                        ),
                      ),
                    if (_tabController.index == 1) verticalSpace(20),
                    TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primaryDeafult,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primaryDeafult,
                      tabs: const [
                        Tab(text: "Ongoing"),
                        Tab(text: "Completed"),
                      ],
                      onTap: (index) {
                        setState(() {});
                        final status = index == 0 ? 'active' : 'history';
                        context
                            .read<AgentsCubit>()
                            .getAllOrdersEachAgent(widget.id, status: status);
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _OrdersListView(
                            orders: filteredOngoingOrders,
                            isOngoing: true,
                            fromDate: null,
                            toDate: null,
                            onClearFilter: null,
                          ),
                          _OrdersListView(
                            orders: filteredCompletedOrders,
                            isOngoing: false,
                            fromDate: _completedFromDate,
                            toDate: _completedToDate,
                            onClearFilter:
                                _completedFromDate != null &&
                                        _completedToDate != null
                                    ? _clearDateRange
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text(state.toString()));
              }
            },
          ),
        );
      },
    );
  }
}

class _OrdersListView extends StatelessWidget {
  final List<dynamic> orders;
  final bool isOngoing;
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback? onClearFilter;

  const _OrdersListView({
    super.key,
    required this.orders,
    required this.isOngoing,
    this.fromDate,
    this.toDate,
    this.onClearFilter,
  });

  String? get _dateRangeLabel {
    if (fromDate != null && toDate != null) {
      // Only show the date part (not the time)
      String formatShortDate(DateTime d) =>
          "${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      return "${formatShortDate(fromDate!)} - ${formatShortDate(toDate!)}";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          isOngoing
              ? "No ongoing orders."
              : (_dateRangeLabel != null
                  ? "No completed orders for $_dateRangeLabel."
                  : "No completed orders."),
        ),
      );
    }

    return Column(
      children: [
        if (!isOngoing && _dateRangeLabel != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  "Filtered by: $_dateRangeLabel",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                if (onClearFilter != null)
                  GestureDetector(
                    onTap: onClearFilter,
                    child: const Icon(Icons.clear, size: 18),
                  ),
              ],
            ),
          ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final order = orders[index];
              // Show multi if the order contains more than one order (i.e., order.orders.length > 1)
              final bool showMulti =
                  order.orders != null && order.orders.length > 1;
              return BlocProvider(
                create: (context) => getIt<AgentsCubit>(),
                child: MyOrderCard(
                  isResturant: true,
                  orderId: order.id,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider(
                              create:
                                  (context) =>
                                      getIt<AgentsCubit>()
                                        ..getEachOrderDeatils(order.id),
                              child: OrderDetailsAgent(),
                            ),
                      ),
                    );
                  },
                  orders: true,
                  multi: showMulti ? Text("Multi") : null,
                  orderStatus:
                      order.status == "delivered"
                          ? "Done"
                          : order.status == "on_the_way"
                          ? "On the way"
                          : order.status,
                  orderStatusColor:
                      order.status == "delivered"
                          ? Colors.green
                          : AppColors.lightGreySecond,
                  restaurantName:
                      'ID #${order.orders?.first.restaurantId?.id.toString().substring(0, 6)} ',
                  shippingPrice:
                      "Shipping Price ${order.finalDeliveryCost} L.E",
                  price: "Order Price ${order.finalPrice} L.E",
                  orderNumber: '#${order.id?.substring(0, 5)}',
                  date: formatDate(order.createdAt),
                  items:
                      '${order.orders?.first.items?.length.toString().padLeft(2, '0')} Items',
                  isOngoing: order.status != "delivered",
                  resId: order.orders?.first.restaurantId?.toString().substring(
                    0,
                    3,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
