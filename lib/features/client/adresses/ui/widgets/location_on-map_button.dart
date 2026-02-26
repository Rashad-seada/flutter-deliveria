import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationOnMapButton extends StatelessWidget {
  const LocationOnMapButton({
    super.key, 
    required this.onPressed,
    this.hasLocation = false,
    this.locationAddress,
    this.onRemove,
  });
  
  final void Function() onPressed;
  final bool hasLocation;
  final String? locationAddress;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    if (hasLocation) {
      // Location is selected - show status card with change/remove options
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.primaryDeafult.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryDeafult,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.locationSelected.tr(),
                        style: TextStyles.bimini14W500.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (locationAddress != null && locationAddress!.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            locationAddress!,
                            style: TextStyles.bimini12W400Grey.copyWith(
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Action buttons row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPressed,
                    icon: Icon(Icons.edit_location_alt, size: 18.sp),
                    label: Text(AppStrings.changeLocation.tr()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryDeafult,
                      side: BorderSide(color: AppColors.primaryDeafult),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onRemove,
                    icon: Icon(Icons.delete_outline, size: 18.sp),
                    label: Text(AppStrings.removeLocation.tr()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
      );
    }

    // No location selected - show pick button
    return Center(
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDeafult, AppColors.primaryDeafult.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDeafult.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_location_alt, color: Colors.white, size: 24.sp),
              SizedBox(width: 10.w),
              Text(
                AppStrings.defineLocationOnMap.tr(),
                style: TextStyles.bimini14W500.copyWith(
                  color: Colors.white, 
                  fontSize: 16.sp, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
