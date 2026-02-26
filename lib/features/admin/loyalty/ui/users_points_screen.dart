import 'dart:async';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/loyalty/data/models/admin_loyalty_models.dart';
import 'package:delveria/features/admin/loyalty/logic/cubit/admin_loyalty_cubit.dart';
import 'package:delveria/features/admin/loyalty/ui/widgets/adjust_points_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersPointsScreen extends StatefulWidget {
  const UsersPointsScreen({super.key});

  @override
  State<UsersPointsScreen> createState() => _UsersPointsScreenState();
}

class _UsersPointsScreenState extends State<UsersPointsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<AdminLoyaltyCubit>().fetchUsers();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<AdminLoyaltyCubit>().loadMoreUsers();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _searchQuery = query);
        context.read<AdminLoyaltyCubit>().fetchUsers(searchQuery: query);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.usersPoints.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: AppStrings.searchByNameOrPhone.tr(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Users list
          Expanded(
            child: BlocConsumer<AdminLoyaltyCubit, AdminLoyaltyState>(
              listener: (context, state) {
                if (state is AdminLoyaltyOperationSuccess) {
                  showSuccessSnackBar(context, state.message);
                } else if (state is AdminLoyaltyError) {
                  showWarningSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                final cubit = context.read<AdminLoyaltyCubit>();
                
                if (state is AdminLoyaltyLoading && cubit.cachedUsers.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Use cached users directly (already filtered/paginated by server)
                final users = cubit.cachedUsers;

                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64.sp, color: Colors.grey),
                        verticalSpace(16),
                        Text(
                          _searchQuery.isEmpty
                              ? AppStrings.noUsersWithPointsYet.tr()
                              : AppStrings.noUsersFound.tr(),
                          style: TextStyles.bimini16W500.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    cubit.fetchUsers(isRefresh: true);
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: users.length + (state is AdminLoyaltyLoading || cubit.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= users.length) {
                         return Padding(
                           padding: EdgeInsets.symmetric(vertical: 16.h),
                           child: const Center(child: CircularProgressIndicator()),
                         );
                      }
                      return _buildUserCard(users[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserPointsSummary user) {
    final points = user.totalPoints ?? 0;
    final legacyPoints = user.legacyPoints ?? 0;
    final rewardsCount = user.totalRewards ?? 0;

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
          // Avatar
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.primaryDeafult.withOpacity(0.1),
            child: Text(
              (user.name?[0] ?? 'U').toUpperCase(),
              style: TextStyles.bimini18W700.copyWith(
                color: AppColors.primaryDeafult,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName.isNotEmpty ? user.fullName : AppStrings.unknownUser.tr(),
                  style: TextStyles.bimini16W700,
                ),
                SizedBox(height: 4.h),
                Text(
                  user.phone ?? AppStrings.noPhone.tr(),
                  style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
                ),
                if (legacyPoints > 0) ...[
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Text(
                      "${AppStrings.legacy.tr()}: $legacyPoints",
                      style: TextStyles.bimini10W500.copyWith(color: Colors.orange),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Points and rewards
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryDeafult.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "$points ${AppStrings.pts.tr()}",
                  style: TextStyles.bimini14W700.copyWith(
                    color: AppColors.primaryDeafult,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "$rewardsCount ${AppStrings.rewards.tr()}",
                style: TextStyles.bimini10W500.copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          // Action button
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'adjust') {
                _showAdjustDialog(user);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'adjust',
                child: Row(
                  children: [
                    const Icon(Icons.add_circle_outline),
                    const SizedBox(width: 8),
                    Text(AppStrings.adjustPoints.tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAdjustDialog(UserPointsSummary user) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<AdminLoyaltyCubit>(),
        child: AdjustPointsDialog(user: user),
      ),
    );
  }
}
