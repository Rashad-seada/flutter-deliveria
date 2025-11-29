import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItemForProfile extends StatelessWidget {
  const InfoItemForProfile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.themeState,
    this.isResturant
  });
  final IconData icon;
  final String label, value;
  final Color iconColor;
  final ThemeState? themeState;
  final bool? isResturant;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: isResturant == true ? 48.w : 40.w,
          height: isResturant == true ? 48.h : 40.h,
          decoration: BoxDecoration(
            shape: isResturant == true ? BoxShape.rectangle : BoxShape.circle,
            color:
                themeState?.themeMode == ThemeMode.dark
                    ? AppColors.darkGrey
                    : isResturant == true
                    ? AppColors.lightGreySecond.withValues(
                      alpha: isResturant == true ? .5 : 0,
                    )
                    : AppColors.lightGreySecond,
            borderRadius:
                isResturant == true ? BorderRadius.circular(8.r) : null
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyles.bimini16W400Body),
              SizedBox(height: 5),
              Text(value, style: TextStyles.bimini13W400Grey),
            ],
          ),
        ),
      ],
    );
  }
}
