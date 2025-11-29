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

class AdminCouponsScreen extends StatefulWidget {
  const AdminCouponsScreen({super.key});

  @override
  State<AdminCouponsScreen> createState() => _AdminCouponsScreenState();
}

class _AdminCouponsScreenState extends State<AdminCouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop: true,
          showTitle: true,
          title: AppStrings.coupons,
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<CouponeCubit, CouponeState>(
          builder: (context, state) {
            final cubit = context.read<CouponeCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(48),
                Text('All Coupons', style: TextStyles.bimini20W700),
                verticalSpace(32),
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.coupons.length,
                    itemBuilder: (context, index) {
                      return CouponCard(
                        coupon:cubit.coupons[index],
                        index: index,
                      );
                    },
                  ),
                ),
                verticalSpace(10),
                Center(
                  child: AppButton(
                    title: AppStrings.addCoupon,
                    onPressed: () {
                      context.pushNamed(Routes.addCouponeScreen);
                    },
                  ),
                ),
                verticalSpace(28),
              ],
            );
          },
        ),
      ),
    );
  }
}
