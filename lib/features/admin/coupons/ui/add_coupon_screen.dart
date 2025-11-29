import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_request.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_state.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/add_coupone_bloc_listener.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/drop_down_order_status_coupon.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/new_coupon_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCouponScreen extends StatefulWidget {
  const AddCouponScreen({super.key});

  @override
  State<AddCouponScreen> createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  bool allResturants = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop: true,
          onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
          showTitle: true,
          title: AppStrings.addNewCoupon,
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<PickDateCubit, PickDateState>(
        builder: (context, state) {
          return BlocBuilder<CouponeCubit, CouponeState>(
            builder: (context, couponeState) {
              final couponeCubit = context.read<CouponeCubit>();
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                  vertical: 40.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      NewCouponForm(
                        couponeCodeController:
                            couponeCubit.couponeCodeController,
                        discountController: couponeCubit.discountController,
                        expDateController: state.expDateController,
                        onTap:
                            () => context.read<PickDateCubit>().pickExpDate(
                              context,
                            ),
                        validNumberController:
                            couponeCubit.validNumberController,
                      ),
                      verticalSpace(10),
                      CheckboxListTile(
                        contentPadding: EdgeInsetsDirectional.zero,
                        value: allResturants,
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: AppColors.primary,
                        title: Text(
                          "Apply For all resturants ",
                          style: TextStyles.bimini16W700,
                        ),
                        onChanged: (p0) {
                          setState(() {
                            allResturants = !allResturants;
                          });
                        },
                      ),
                      DropDownOrderStatusCoupon(),
                      verticalSpace(100),
                      AddCouponeBlocListener(
                        child: AppButton(
                          title: AppStrings.saveCoupon,
                          onPressed: () {
                            couponeCubit.creatCoupone(
                              request: CouponeRequest(
                                restaurant:
                                    allResturants
                                        ? "Full"
                                        : couponeCubit.resturantId,
                                code: couponeCubit.couponeCodeController.text,
                                numberEnable:
                                    couponeCubit.validNumberController.text,
                                discount:
                                    int.tryParse(
                                      couponeCubit.discountController.text,
                                    ) ??
                                    0,
                                expiredDate: state.expDateController.text,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
