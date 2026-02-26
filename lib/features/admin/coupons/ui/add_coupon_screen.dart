import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/features/admin/coupons/data/models/coupon.dart';
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
  final Coupon? coupon;
  const AddCouponScreen({super.key, this.coupon});

  @override
  State<AddCouponScreen> createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  bool allResturants = false;
  
  @override
  void initState() {
    super.initState();
    final couponeCubit = context.read<CouponeCubit>();
    final pickDateCubit = context.read<PickDateCubit>();
    
    if (widget.coupon != null) {
      couponeCubit.initializeForEdit(widget.coupon!);
      pickDateCubit.setInitialDate(widget.coupon!.expiredDate);
    } else {
      couponeCubit.resetControllers();
      pickDateCubit.resetDate(); 
    }
  }

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
          title: widget.coupon != null ? AppStrings.updateCoupon : AppStrings.addNewCoupon,
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
                  child: Form(
                    key: couponeCubit.formKey,
                    child: Column(
                      children: [
                        NewCouponForm(
                          couponeCodeController: couponeCubit.couponeCodeController,
                          discountController: couponeCubit.discountController,
                          expDateController: state.expDateController,
                          validNumberController: couponeCubit.validNumberController,
                          usagePerUserController: couponeCubit.usagePerUserController,
                          minOrderValueController: couponeCubit.minOrderValueController,
                          descriptionController: couponeCubit.descriptionController,
                          currentDiscountType: couponeCubit.discountType,
                          currentCouponType: couponeCubit.couponType,
                          onDiscountTypeChanged: (val) {
                            setState(() {
                              couponeCubit.discountType = val ?? 'bill';
                            });
                          },
                          onCouponTypeChanged: (val) {
                            setState(() {
                              couponeCubit.couponType = val ?? 'promotional';
                            });
                          },
                          onTap: () => context.read<PickDateCubit>().pickExpDate(context),
                        ),
                        verticalSpace(10),
                        CheckboxListTile(
                          contentPadding: EdgeInsetsDirectional.zero,
                          value: couponeCubit.isAllRestaurants,
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: AppColors.primary,
                          title: Text(
                            "Apply For all resturants ",
                            style: TextStyles.bimini16W700,
                          ),
                          onChanged: (val) {
                            setState(() {
                              couponeCubit.isAllRestaurants = val ?? false;
                            });
                          },
                        ),
                        if (!couponeCubit.isAllRestaurants)
                          DropDownOrderStatusCoupon(),
                        verticalSpace(100),
                        AddCouponeBlocListener(
                          child: AppButton(
                            title: widget.coupon != null ? AppStrings.updateCoupon : AppStrings.saveCoupon,
                            onPressed: () {
                              if (widget.coupon != null) {
                                  couponeCubit.updateCoupon(
                                    id: widget.coupon!.id,
                                    // Form data is used if updates map is null
                                    updates: null 
                                  );
                              } else {
                                  couponeCubit.creatCoupone(
                                    expiredDate: state.expDateController.text,
                                  );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
