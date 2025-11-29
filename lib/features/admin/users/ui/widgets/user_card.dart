import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.order,
    //  this.money,
    required this.phone,
    this.isFromNotification,
    this.onCheckTap,
    this.isSelected, required this.index,
  });
  final String name, email, order, phone;
  final bool? isFromNotification;
  final void Function()? onCheckTap;
  final List<bool>? isSelected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 5,
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: AppColors.userBackGroundColor.withValues(alpha: .1),
          child: Image.asset(AppImages.user, width: 58.w, height: 58.h),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            spacing: isFromNotification == true ? 4 : 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyles.bimini16W400Body,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: onCheckTap,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isFromNotification == true
                                  ? AppColors.primaryDeafult
                                  : isSelected?[index] == true
                                  ? AppColors.primaryDeafult
                                  : Colors.black.withValues(alpha: .3),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          isFromNotification == true
                              ? Icon(
                                Icons.check,
                                color: AppColors.primaryDeafult,
                              )
                              : isSelected?[index] == true
                              ? Icon(
                                Icons.check,
                                color: AppColors.primaryDeafult,
                              )
                              : SizedBox(),
                    ),
                  ),
                ],
              ),
              Text(email, style: TextStyles.bimini13W400Grey),
              isFromNotification == true
                  ? SizedBox()
                  : Text(order, style: TextStyles.bimini13W400Grey),

              Text(phone, style: TextStyles.bimini16W400Body),
            ],
          ),
        ),
      ],
    );
  }
}
