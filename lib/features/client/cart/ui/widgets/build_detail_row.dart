import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildDetailRow(
  String label,
  String value, {
  bool isTotal = false,
  bool isAccepted = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
     
   
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: isTotal
                  ? TextStyles.bimini20W700.copyWith(
                      color: AppColors.primaryDeafult,
                    )
                  : TextStyles.bimini20W700.copyWith(
                      color: state.themeMode == ThemeMode.dark
                          ? AppColors.lightGrey
                          : AppColors.darkGrey,
                    ),
            ),
 Text(
                    value,
                    style: isTotal
                        ? TextStyles.bimini20W700
                        : TextStyles.bimini16W400Body.copyWith(
                            color: AppColors.grey,
                          ),
                  ),
            // isAccepted 
            //     ? Text.rich(
            //         TextSpan(
            //           children: [
            //             TextSpan(
            //               text:
            //                   "${discountedPrice!.toStringAsFixed(2)} L.E",
            //               style: TextStyles.bimini16W400Body.copyWith(
            //                 color: AppColors.green,
            //               ),
            //             ),
            //             TextSpan(
            //               text: " instead of",
            //               style: TextStyles.bimini16W400Body,
            //             ),
            //             TextSpan(
            //               text: " ${originalPrice.toStringAsFixed(2)} L.E ",
            //               style: TextStyles.bimini16W400Body.copyWith(
            //                 decoration: TextDecoration.lineThrough,
            //                 color: AppColors.grey,
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     :
          ],
        );
      },
    ),
  );
}
