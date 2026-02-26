import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminCouponsScreen extends StatefulWidget {
  const AdminCouponsScreen({super.key});

  @override
  State<AdminCouponsScreen> createState() => _AdminCouponsScreenState();
}

class _AdminCouponsScreenState extends State<AdminCouponsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch coupons when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CouponeCubit>().getCoupons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop: true,
          showTitle: true,
          title: AppStrings.coupons.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.coupons.tr(), style: TextStyles.bimini20W700),
                IconButton(
                  onPressed: () {
                     context.read<CouponeCubit>().getCoupons();
                  }, 
                  icon: Icon(Icons.refresh, color: AppColors.primary)
                ),
              ],
            ),
            verticalSpace(16),
            Expanded(
              child: BlocBuilder<CouponeCubit, CouponeState>(
                builder: (context, state) {
                  final cubit = context.read<CouponeCubit>();
                  
                  // Check for explicit loading state
                  // Note: verify if state.maybeWhen is preferred or manual check
                  // Since CouponeState is freezed, we can use try/catch or simple check if we had logic
                  // But relying on cubit.coupons is risky if loading.
                  
                  return state.maybeWhen(
                    getCouponsLoading: () => Center(child: CircularProgressIndicator()),
                    getCouponsFail: (error) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(error.message),
                          verticalSpace(8),
                          AppButton(
                            title: "Retry",
                            onPressed: () => cubit.getCoupons(),
                          )
                        ],
                      ),
                    ),
                    orElse: () {
                      if (cubit.coupons.isEmpty) {
                        return Center(child: Text("No coupons found"));
                      }
                      return ListView.builder(
                        itemCount: cubit.coupons.length,
                        itemBuilder: (context, index) {
                          return CouponCard(
                            coupon: cubit.coupons[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            verticalSpace(10),
            Center(
              child: AppButton(
                title: AppStrings.addCoupon.tr(),
                onPressed: () {
                  context.pushNamed(Routes.addCouponeScreen);
                },
              ),
            ),
            verticalSpace(28),
          ],
        ),
      ),
    );
  }
}
