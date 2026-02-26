import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/loyalty/data/models/admin_loyalty_models.dart';
import 'package:delveria/features/admin/loyalty/logic/cubit/admin_loyalty_cubit.dart';
import 'package:delveria/features/admin/loyalty/ui/widgets/tier_form_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardTiersScreen extends StatefulWidget {
  const RewardTiersScreen({super.key});

  @override
  State<RewardTiersScreen> createState() => _RewardTiersScreenState();
}

class _RewardTiersScreenState extends State<RewardTiersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminLoyaltyCubit>().fetchTiers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.rewardTiers.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTierDialog(context),
        backgroundColor: AppColors.primaryDeafult,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocConsumer<AdminLoyaltyCubit, AdminLoyaltyState>(
        listener: (context, state) {
          if (state is AdminLoyaltyOperationSuccess) {
            showSuccessSnackBar(context, state.message);
          } else if (state is AdminLoyaltyError) {
            showWarningSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AdminLoyaltyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final tiers = context.read<AdminLoyaltyCubit>().cachedTiers;

          if (tiers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events_outlined, size: 64.sp, color: Colors.grey),
                  verticalSpace(16),
                  Text(
                    AppStrings.noRewardTiersYet.tr(),
                    style: TextStyles.bimini16W500.copyWith(color: Colors.grey),
                  ),
                  verticalSpace(8),
                  Text(
                    AppStrings.tapPlusToCreateTier.tr(),
                    style: TextStyles.bimini14W500.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: tiers.length,
            itemBuilder: (context, index) => _buildTierCard(tiers[index]),
          );
        },
      ),
    );
  }

  Widget _buildTierCard(AdminRewardTier tier) {
    final isActive = tier.isActive ?? true;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isActive ? AppColors.primaryDeafult.withOpacity(0.2) : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (isActive ? AppColors.primaryDeafult : Colors.grey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: isActive ? AppColors.primaryDeafult : Colors.grey,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tier.name ?? '',
                          style: TextStyles.bimini18W700.copyWith(
                            color: isActive ? Colors.black87 : Colors.grey,
                          ),
                        ),
                        if (!isActive) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              AppStrings.inactive.tr(),
                              style: TextStyles.bimini10W700.copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${tier.pointsRequired ?? 0} ${AppStrings.pointsRequired.tr().toLowerCase()}",
                      style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Discount badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  tier.discountType == 'percentage'
                      ? "${tier.discountValue?.toInt() ?? 0}%"
                      : "${tier.discountValue?.toInt() ?? 0} EGP",
                  style: TextStyles.bimini14W700.copyWith(color: Colors.green),
                ),
              ),
            ],
          ),
          if (tier.description != null && tier.description!.isNotEmpty) ...[
            verticalSpace(12),
            Text(
              tier.description!,
              style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
            ),
          ],
          verticalSpace(16),
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _showTierDialog(context, tier: tier),
                icon: Icon(Icons.edit, size: 18.sp),
                label: Text(AppStrings.edit.tr()),
              ),
              TextButton.icon(
                onPressed: () => _toggleTierStatus(tier),
                icon: Icon(
                  isActive ? Icons.visibility_off : Icons.visibility,
                  size: 18.sp,
                ),
                label: Text(isActive ? AppStrings.deactivate.tr() : AppStrings.activate.tr()),
                style: TextButton.styleFrom(
                  foregroundColor: isActive ? Colors.orange : Colors.green,
                ),
              ),
              TextButton.icon(
                onPressed: () => _confirmDelete(tier),
                icon: Icon(Icons.delete, size: 18.sp),
                label: Text(AppStrings.delete.tr()),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTierDialog(BuildContext context, {AdminRewardTier? tier}) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<AdminLoyaltyCubit>(),
        child: TierFormDialog(tier: tier),
      ),
    );
  }

  void _toggleTierStatus(AdminRewardTier tier) {
    final isActive = tier.isActive ?? true;
    context.read<AdminLoyaltyCubit>().updateTier(
      tier.id!,
      isActive: !isActive,
    );
  }

  void _confirmDelete(AdminRewardTier tier) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppStrings.deleteTier.tr()),
        content: Text("${AppStrings.confirmDeleteTier.tr()} '${tier.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppStrings.cancel.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AdminLoyaltyCubit>().deleteTier(tier.id!);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppStrings.delete.tr()),
          ),
        ],
      ),
    );
  }
}
