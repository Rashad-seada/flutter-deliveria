import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/features/admin/coupons/data/models/get_all_coupon_response.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_state.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/coupon_image.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/coupon_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:delveria/features/admin/coupons/data/models/coupon.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;

  const CouponCard({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    // Valid if active and not expired
    final bool isValid = coupon.isActive && !coupon.isExpired;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isValid ? AppColors.primary : AppColors.lightGrey,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.code,
                    style: TextStyles.bimini20W700.copyWith(
                      color: isValid ? AppColors.primary : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coupon.couponType.toUpperCase().replaceAll('_', ' '),
                    style: TextStyles.bimini12W500.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isValid ? AppColors.primary.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  coupon.discountType == 'bill' 
                      ? '${coupon.value}% OFF' 
                      : 'Free Delivery',
                  style: TextStyles.bimini14W700.copyWith(
                    color: isValid ? AppColors.primary : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      icon: Icons.calendar_today,
                      label: 'Expires: ${DateFormat('MMM dd, yyyy').format(coupon.expiredDate)}',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      icon: Icons.people,
                      label: 'Used: ${coupon.usersUsed.length} / ${coupon.usageLimit ?? "∞"}',
                    ),
                  ],
                ),
              ),
              Switch(
                value: coupon.isActive,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  context.read<CouponeCubit>().changeCouponStatus(couponeId: coupon.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: AppColors.primary),
                onPressed: () {
                   Navigator.pushNamed(context, Routes.addCouponeScreen, arguments: coupon);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyles.bimini12W500.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
  
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Coupon'),
        content: Text('Are you sure you want to delete ${coupon.code}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CouponeCubit>().deleteCoupon(coupon.id);
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
