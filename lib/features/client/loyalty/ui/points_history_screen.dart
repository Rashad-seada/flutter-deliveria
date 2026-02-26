import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_history_response.dart';
import 'package:delveria/features/client/loyalty/logic/cubit/loyalty_cubit.dart';
import 'package:delveria/features/client/loyalty/logic/cubit/loyalty_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PointsHistoryScreen extends StatefulWidget {
  const PointsHistoryScreen({super.key});

  @override
  State<PointsHistoryScreen> createState() => _PointsHistoryScreenState();
}

class _PointsHistoryScreenState extends State<PointsHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;
  List<PointsTransaction> _transactions = [];
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadHistory({bool refresh = false}) {
    if (refresh) {
      _currentPage = 1;
      _transactions = [];
      _hasMore = true;
    }
    context.read<LoyaltyCubit>().fetchHistory(page: _currentPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (_hasMore && !_isLoadingMore) {
      _isLoadingMore = true;
      _currentPage++;
      context.read<LoyaltyCubit>().fetchHistory(page: _currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.pointsHistory.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocConsumer<LoyaltyCubit, LoyaltyState>(
        listener: (context, state) {
          if (state is LoyaltyHistoryLoaded) {
            setState(() {
              _isLoadingMore = false;
              final newTransactions = state.history.transactions ?? [];
              if (_currentPage == 1) {
                _transactions = newTransactions;
              } else {
                _transactions.addAll(newTransactions);
              }
              final pagination = state.history.pagination;
              if (pagination != null) {
                _hasMore = (pagination.page ?? 1) < (pagination.pages ?? 1);
              }
            });
          }
        },
        builder: (context, state) {
          if (state is LoyaltyHistoryLoading && _transactions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoyaltyError && _transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: Colors.grey),
                  verticalSpace(16),
                  Text(state.message, style: TextStyles.bimini14W500),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () => _loadHistory(refresh: true),
                    child: Text(AppStrings.retry.tr()),
                  ),
                ],
              ),
            );
          }

          if (_transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64.sp, color: Colors.grey),
                  verticalSpace(16),
                  Text(
                    AppStrings.noTransactionsYet.tr(),
                    style: TextStyles.bimini16W500.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _loadHistory(refresh: true);
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.w),
              itemCount: _transactions.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _transactions.length) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
                return _buildTransactionCard(_transactions[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionCard(PointsTransaction transaction) {
    final isEarn = transaction.type == 'earn';
    final isRedeem = transaction.type == 'redeem';
    final isAdjust = transaction.type == 'admin_adjust';

    IconData icon;
    Color color;
    String prefix;

    if (isEarn) {
      icon = Icons.add_circle;
      color = Colors.green;
      prefix = '+';
    } else if (isRedeem) {
      icon = Icons.remove_circle;
      color = Colors.orange;
      prefix = '-';
    } else if (isAdjust) {
      icon = Icons.admin_panel_settings;
      color = (transaction.points ?? 0) >= 0 ? Colors.blue : Colors.red;
      prefix = (transaction.points ?? 0) >= 0 ? '+' : '';
    } else {
      icon = Icons.history;
      color = Colors.grey;
      prefix = '';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description ?? _getDefaultDescription(transaction.type),
                  style: TextStyles.bimini14W600,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  _formatDate(transaction.createdAt),
                  style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$prefix${transaction.points ?? 0}",
                style: TextStyles.bimini18W700.copyWith(color: color),
              ),
              Text(
                "${AppStrings.balance.tr()}: ${transaction.balance ?? 0}",
                style: TextStyles.bimini10W500.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDefaultDescription(String? type) {
    switch (type) {
      case 'earn':
        return AppStrings.pointsEarned.tr();
      case 'redeem':
        return AppStrings.pointsRedeemed.tr();
      case 'admin_adjust':
        return AppStrings.adminAdjustment.tr();
      case 'expire':
        return AppStrings.pointsExpired.tr();
      default:
        return AppStrings.transaction.tr();
    }
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return isoDate;
    }
  }
}
