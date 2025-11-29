import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewItem extends StatelessWidget {
  final String date;
  final String title;
  final int rating;
  // final String comment;

  const ReviewItem({
    super.key,
    required this.date,
    required this.title,
    required this.rating,
    // required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Container(
          width: 43.w,
          height: 43.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyBlue,
          ),
        ),
        Container(
          width: 274.w,
          height:150 .h,
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.greyBlue.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(12),
          
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                children: [
                 
               
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: TextStyles.sen14W400.copyWith(
                                fontSize: 12.sp, 
                                color: AppColors.grey
                              )
                            ),
                              PopupMenuButton(
                                
                                padding: EdgeInsetsGeometry.zero,
                                menuPadding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.grey[400],
                              ),
                              itemBuilder:
                                  (context) => [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text(AppStrings.edit.tr()),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text(AppStrings.delete).tr(),
                                    ),
                                  ],
                            ),
                          ],
                        ),
                        Text(
                          title,
                          style: TextStyles.bimini13W700Deafult.copyWith(
                            color: Colors.black
                          )
                        ),
                      ],
                    ),
                  ),
                
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: index < rating ? AppColors.primaryDeafult : Colors.grey[300],
                  );
                }),
              ),
              SizedBox(height: 8),
              // Text(
              //   comment,
              //   style: TextStyles.bimini13W400Grey
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
