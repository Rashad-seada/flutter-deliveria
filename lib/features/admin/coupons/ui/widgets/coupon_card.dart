import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/coupons/data/models/get_all_coupon_response.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_state.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/coupon_image.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/coupon_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CouponCard extends StatefulWidget {
  final CouponCode coupon;
  final int index;

  const CouponCard({super.key, required this.coupon, required this.index});

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  bool _isCouponValidByDate(String expiredDate) {
    DateTime? expiry;
    final now = DateTime.now();

    try {
      expiry = DateTime.parse(expiredDate);
    } catch (_) {
      try {
        expiry = DateFormat('d/M/yyyy').parseStrict(expiredDate);
      } catch (_) {
        try {
          expiry = DateFormat('M/d/yyyy').parseStrict(expiredDate);
        } catch (_) {
          try {
            expiry = DateFormat('d-M-yyyy').parseStrict(expiredDate);
          } catch (_) {
            try {
              expiry = DateFormat('yyyy-MM-dd').parseStrict(expiredDate);
            } catch (_) {
              expiry = null;
            }
          }
        }
      }
    }
    if (expiry == null) return false;
    return expiry.isAfter(now);
  }

  @override
  Widget build(BuildContext context) {
    final isValid =
        widget.coupon.enable == true &&
        _isCouponValidByDate(widget.coupon.expiredDate);

    return BlocBuilder<PickDateCubit, PickDateState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          padding: EdgeInsets.only(left: 4, top: 2),
          margin: const EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
            color: isValid ? Colors.white : AppColors.lightGrey,
          ),
          child: BlocConsumer<CouponeCubit, CouponeState>(
            builder: (context, couponeState) {
              final cubit = context.read<CouponeCubit>();
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CouponInformation(
                        couponStateText: isValid ? "valid" : "Expired",
                        widget: widget,
                        pickDateState: state,
                        index: widget.index,
                      ),
                      CouponImage(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isValid ? 'Valid Coupon' : 'Expired Coupon',
                        style: TextStyles.bimini16W700,
                      ),
                      const SizedBox(width: 8),
                      Transform.scale(
                        scale: .8,
                        child: Switch(
                          value: isValid,
                          onChanged: (val) async {
                            if (_isCouponValidByDate(
                              widget.coupon.expiredDate,
                            )) {
                              await context.read<CouponeCubit>().changeCouponStatus(
                                couponeId: widget.coupon.id,
                              );
                              await context.read<CouponeCubit>().getCouponse();
                            } else {
                              showWarningSnackBar(
                                context,
                                "This coupone is expired you can’t change it ",
                              );
                            }
                          }, // Disabled, since validity is based on date
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            listener: (BuildContext context, CouponeState<dynamic> state) {
              if (state is ChangeStatusSuccess) {
                showSuccessSnackBar(context, "Coupone status  successfully");
              }
            },
          ),
        );
      },
    );
  }
}
