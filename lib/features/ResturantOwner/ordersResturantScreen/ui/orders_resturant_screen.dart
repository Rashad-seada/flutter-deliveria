import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart'; // <-- fix: import styles
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/new_orders_tab_body.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/orders_tab_body.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/oreder_res_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // <-- fix: import intl for DateFormat

class OrdersResturantScreen extends StatefulWidget {
  const OrdersResturantScreen({super.key});

  @override
  State<OrdersResturantScreen> createState() => _OrdersResturantScreenState();
}

class _OrdersResturantScreenState extends State<OrdersResturantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      // Redraw to show/hide filter icon when switching tab
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showDateRangeFilterDialog() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange:
          (_fromDate != null && _toDate != null)
              ? DateTimeRange(start: _fromDate!, end: _toDate!)
              : null,
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked.start;
        _toDate = picked.end;
      });
    }
  }

  void _clearDateRange() {
    setState(() {
      _fromDate = null;
      _toDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: OrderResAppBar(
          tabController: _tabController,
          showFilter: true, // Always show filter in AppBar if on "Orders" tab
          onRefresh: () {
            context.read<OrdersResturantCubit>().getOrdersRestuant();
          },
          fromDate: _fromDate,
          toDate: _toDate,
          onFilterPressed: _showDateRangeFilterDialog,
          onClearDateRange: _clearDateRange,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // New Orders tab: No filter controls in tab body
          NewOrdersTapBody(isDeliveryAgent: false),
          // Orders tab: No filter row here, it's now in AppBar
          Column(
            children: [
              if (true &&
                  _tabController.index == 1 &&
                  _fromDate != null &&
                  _toDate != null)
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${DateFormat('yyyy/MM/dd').format(_fromDate!)} - ${DateFormat('yyyy/MM/dd').format(_toDate!)}",
                          style: TextStyles.bimini14W500.copyWith(
                            color: AppColors.primaryDeafult,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: _clearDateRange,
                        child: Text(
                          "Clear",
                          style: TextStyles.bimini13W400Grey.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              BlocProvider(
                create:
                    (context) =>
                        getIt<OrdersResturantCubit>()..getOrdersRestuant(),
                child: OrdersTabBody(
                  isDeliveryAgent: false,
                  filterFromDate: _fromDate,
                  filterToDate: _toDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
