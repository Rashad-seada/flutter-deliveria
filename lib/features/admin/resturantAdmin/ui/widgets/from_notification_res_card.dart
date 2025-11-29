import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromNotificationResCard extends StatelessWidget {
  const FromNotificationResCard({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Row(
      children: [
        Container(
          height: 162.h,
          width: 137.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(AppImages.burger),
        ),
     horizontalSpace(10),
        Expanded(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Italian Cuisine",
                    style: TextStyles.bimini16W400Body,
                  ),
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      border: Border.all(
                        color: AppColors.primaryDeafult
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.check, color: AppColors.primaryDeafult,),
                  ),
                ],
              ),
              Text(
                "Eldekka Restaurant",
                style: TextStyles.bimini16W700,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 171.w,
                child: Text(
                  "street restautants-styles tacos with a varirty of Fillings",
                  style: TextStyles.bimini13W400Grey,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
