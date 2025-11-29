import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentCard extends StatelessWidget {
  const AgentCard({
    super.key,
    required this.name,
    required this.phone,
    this.onCheckTap,
    this.isSelected,
    required this.index, this.widget,
  });
  final String name, phone;
  final void Function()? onCheckTap;
  final List<bool>? isSelected;
  final int index;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 5,
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: AppColors.userBackGroundColor.withValues(alpha: .1),
          child: Image.asset(AppImages.userBoy, width: 58.w, height: 58.h),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            spacing: 8,
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
                  widget??SizedBox(),
                  GestureDetector(
                    onTap: onCheckTap,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isSelected?[index] == true
                                  ? AppColors.primaryDeafult
                                  : Colors.black.withValues(alpha: .3),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          isSelected?[index] == true
                              ? Icon(
                                Icons.check,
                                color: AppColors.primaryDeafult,
                              )
                              : SizedBox(),
                    ),
                  ),
                ],
              ),

              Text(phone, style: TextStyles.bimini16W400Body),
            ],
          ),
        ),
      ],
    );
  }
}
