import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_drop_down/styled_drop_down.dart';

class DropDownOrderStatusCoupon extends StatefulWidget {
  const DropDownOrderStatusCoupon({super.key});

  @override
  State<DropDownOrderStatusCoupon> createState() =>
      _DropDownOrderStatusCouponState();
}

class _DropDownOrderStatusCouponState extends State<DropDownOrderStatusCoupon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponeCubit, CouponeState>(
      builder: (context, state) {
        final couponeCubit = context.read<CouponeCubit>();
        return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
          builder: (context, resturantState) {
            final resCubit = context.read<AllresturantsadminCubit>();
            List<String?> items =
                resCubit.allResturants.map((e) => e.name).toList();
            return StyledDropDown(
              maxHeight: 150,
              dropDownBodyColor: AppColors.lightGrey,
              itemBuilder: (context, item, selected) {
                return Row(
                  children: [
                    SizedBox(width: 200, child: Text(item)),
                    Spacer(),
                    selected
                        ? Icon(Icons.check, color: AppColors.primaryDeafult)
                        : SizedBox(),
                  ],
                );
              },
              itemContainerColor: AppColors.lightGrey,
              value:
                  couponeCubit.selectedResValue.length > 20
                      ? couponeCubit.selectedResValue.substring(0, 20)
                      : couponeCubit.selectedResValue,
              items: items.map((item)=> item ?? "Unknown").toList(),
              onChanged: (value) {
                final selectedRestaurant = resCubit.allResturants.firstWhere(
                  (element) => element.name == value,
                );
                final selectedId = selectedRestaurant.id;
                couponeCubit.updateSelectedRes(newVal: value, resId: selectedId);
                setState(() {}); 
              },
            );
          },
        );
      },
    );
  }
}
