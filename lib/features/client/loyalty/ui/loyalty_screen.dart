import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:delveria/features/client/loyalty/logic/cubit/loyalty_cubit.dart';
import 'package:delveria/features/client/loyalty/logic/cubit/loyalty_state.dart';
import 'package:delveria/features/client/loyalty/ui/widgets/next_tier_card.dart';
import 'package:delveria/features/client/loyalty/ui/widgets/reward_code_card.dart';
import 'package:delveria/features/client/loyalty/ui/widgets/vertical_progress_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoyaltyScreen extends StatefulWidget {
  const LoyaltyScreen({super.key});

  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoyaltyCubit>().fetchDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.myRewards.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<LoyaltyCubit, LoyaltyState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (dashboard) => _buildDashboard(dashboard),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: Colors.grey),
                  verticalSpace(16),
                  Text(message, style: TextStyles.bimini14W500),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () => context.read<LoyaltyCubit>().fetchDashboard(),
                    child: Text(AppStrings.retry.tr()),
                  ),
                ],
              ),
            ),
            historyLoading: () => const Center(child: CircularProgressIndicator()),
            historyLoaded: (_) => const SizedBox(),
            validating: () => const Center(child: CircularProgressIndicator()),
            validated: (_) => const SizedBox(),
            validationFailed: (_) => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildDashboard(LoyaltyDashboard dashboard) {
    final availableCodes = dashboard.earnedRewards
            ?.where((r) => r.isUsed != true)
            .toList() ??
        [];
    final usedCodes = dashboard.earnedRewards
            ?.where((r) => r.isUsed == true)
            .toList() ??
        [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Points Header
          _buildPointsHeader(dashboard.totalPoints ?? 0),
          verticalSpace(24),

          // Next Tier Card
          if (dashboard.nextTier != null)
            NextTierCard(nextTier: dashboard.nextTier!),
          verticalSpace(24),

          // Vertical Progress Bar
          Text(
            AppStrings.tierProgress.tr(),
            style: TextStyles.bimini18W700.copyWith(color: AppColors.primaryDeafult),
          ),
          verticalSpace(16),
          if (dashboard.tiers != null && dashboard.tiers!.isNotEmpty)
            VerticalProgressBar(
              tiers: dashboard.tiers!,
              currentPoints: dashboard.totalPoints ?? 0,
            ),
          verticalSpace(32),

          // Available Codes
          if (availableCodes.isNotEmpty) ...[
            Text(
              AppStrings.yourCodes.tr(),
              style: TextStyles.bimini18W700.copyWith(color: AppColors.primaryDeafult),
            ),
            verticalSpace(12),
            ...availableCodes.map((code) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: RewardCodeCard(reward: code, isUsed: false),
                )),
            verticalSpace(16),
          ],

          // Used Codes
          if (usedCodes.isNotEmpty) ...[
            Text(
              AppStrings.usedCodes.tr(),
              style: TextStyles.bimini16W700.copyWith(color: Colors.grey),
            ),
            verticalSpace(12),
            ...usedCodes.map((code) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: RewardCodeCard(reward: code, isUsed: true),
                )),
          ],

          verticalSpace(16),
          
          // View History Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                context.pushNamed(Routes.pointsHistoryScreen);
              },
              icon: const Icon(Icons.history),
              label: Text(AppStrings.viewPointsHistory.tr()),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                side: BorderSide(color: AppColors.primaryDeafult),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          
          verticalSpace(32),
        ],
      ),
    );
  }

  Widget _buildPointsHeader(int points) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDeafult, AppColors.primaryDeafult.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDeafult.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.stars_rounded, size: 48.sp, color: Colors.white),
          verticalSpace(8),
          Text(
            "$points",
            style: TextStyles.bimini32W700.copyWith(color: Colors.white),
          ),
          Text(
            AppStrings.totalPoints.tr(),
            style: TextStyles.bimini14W500.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
