import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdressCard extends StatelessWidget {
  const AdressCard({
    super.key,
    required this.index,
    required this.stateTheme,
    required this.addressCubit,
    required this.addressId,
  });
  final int index;
  final ThemeState stateTheme;
  final CreateAddressCubit addressCubit;
  final String addressId;

  @override
  Widget build(BuildContext context) {
    final address = addressCubit.addresses[index];
    final bool isDefault = address.isDefault;
    final bool isDark = stateTheme.themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: () async {
        await addressCubit.changeDefaultAdress(addressId: addressId);
        await addressCubit.getAdresses();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark
              ? (isDefault
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.04))
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDefault
                ? AppColors.primaryDeafult
                : (isDark
                    ? Colors.white.withOpacity(0.1)
                    : const Color(0xFFE8E8E8)),
            width: isDefault ? 1.5 : 1,
          ),
          boxShadow: isDefault
              ? [
                  BoxShadow(
                    color: AppColors.primaryDeafult.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: icon + title + default badge + delete
            Row(
              children: [
                // Location icon container
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isDefault
                        ? AppColors.primaryDeafult.withOpacity(0.1)
                        : (isDark
                            ? Colors.white.withOpacity(0.06)
                            : const Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isDefault
                        ? Icons.location_on_rounded
                        : Icons.location_on_outlined,
                    size: 20.sp,
                    color: isDefault
                        ? AppColors.primaryDeafult
                        : (isDark ? Colors.grey[400] : Colors.grey[500]),
                  ),
                ),
                SizedBox(width: 12.w),

                // Title + default badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              address.addressTitle,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isDefault) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryDeafult.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 12.sp,
                                    color: AppColors.primaryDeafult,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    AppStrings.defaultT.tr(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryDeafult,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Delete button
                _buildDeleteButton(context),
              ],
            ),

            SizedBox(height: 12.h),

            // Divider
            Container(
              height: 1,
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFF0F0F0),
            ),

            SizedBox(height: 12.h),

            // Details row
            Row(
              children: [
                Icon(
                  Icons.notes_rounded,
                  size: 15.sp,
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    address.details.isNotEmpty
                        ? address.details
                        : "No details",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Phone row (if available)
            if (address.phone.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 15.sp,
                    color: isDark ? Colors.grey[500] : Colors.grey[400],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    address.phone,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],

            // Tap hint for non-default
            if (!isDefault) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(
                    Icons.touch_app_outlined,
                    size: 13.sp,
                    color: isDark ? Colors.grey[600] : Colors.grey[350],
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    AppStrings.tapToSetDefault.tr(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: isDark ? Colors.grey[600] : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: () async {
          // Prevent deleting the last address
          if (addressCubit.addresses.length == 1) {
            showWarningSnackBar(
              context,
              AppStrings.cannotDeleteAdress.tr(),
            );
            return;
          }

          // Show confirmation dialog
          final shouldDelete = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                AppStrings.deleteAddress.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Text(
                AppStrings.areYouSureYouWantToDeleteThisAddress.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(
                    AppStrings.cancel.tr(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(
                    AppStrings.delete.tr(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );

          if (shouldDelete == true) {
            print("❌ addresId $addressId");
            await addressCubit.deleteAddress(addressId: addressId);
            await addressCubit.getAdresses();
          }
        },
        child: Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Image.asset(
              AppImages.trashRed,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ),
    );
  }
}
