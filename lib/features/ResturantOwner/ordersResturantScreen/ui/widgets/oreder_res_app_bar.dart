import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderResAppBar extends StatelessWidget {
  const OrderResAppBar({
    super.key,
    required TabController tabController,
    this.onRefresh,
    this.fromDate,
    this.toDate,
    this.onFilterPressed,
    this.onClearDateRange,
    required this.showFilter,
  }) : _tabController = tabController;

  final TabController _tabController;
  final void Function()? onRefresh;
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback? onFilterPressed;
  final VoidCallback? onClearDateRange;
  final bool showFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersResturantCubit, OrdersResturantState>(
      builder: (context, state) {
        return AppBar(
          toolbarHeight: 120,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: AppColors.darkBrown,
          ),
          actions:
              state is Loading
                  ? [CustomLoading()]
                  : [
                    IconButton(
                      onPressed: onRefresh,
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.primaryDeafult,
                      ),
                    ),
                    if (showFilter && _tabController.index == 1)
                      GestureDetector(
                        onTap: onFilterPressed,
                        child: Icon(
                          Icons.filter_alt_rounded,
                          color: AppColors.primaryDeafult,
                        ),
                      ),
             
                  ],
          title: Text(
            AppStrings.orders.tr(),
            style: TextStyles.bimini20W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: Column(
              children: [
                Container(
                  width: 343.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppStrings.searchYourRestuarnt.tr(),
                      hintStyle: TextStyles.bimini16W400Body,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppImages.searchIcon,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
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
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  indicatorColor: Colors.red[800],
                  indicatorWeight: 2,
                  dividerColor: AppColors.grey.withOpacity(.4),
                  tabs: [
                    Tab(text: AppStrings.newOrders.tr()),
                    Tab(text: AppStrings.orders.tr()),
                  ],
                ),
                // Only show filter if showFilter is true AND currently on "orders" tab (index 1)
            
              ],
            ),
          ),
        );
      },
    );
  }
}
