import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationItem extends StatelessWidget {
  final String name;
  final String action;
  final String time;

  const NotificationItem({
    super.key,
    required this.name,
    required this.action,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[400],
          child: Icon(Icons.person, color: Colors.white, size: 30),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: name,
                          style: TextStyles.bimini16W700.copyWith(
                            color:
                                state.themeMode == ThemeMode.dark
                                    ? AppColors.lightGreySecond
                                    : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '  $action',
                          style: TextStyles.bimini16W400Body.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              verticalSpace(5),
              Text(time, style: TextStyles.bimini13W400Grey),
            ],
          ),
        ),
      ],
    );
  }
}
