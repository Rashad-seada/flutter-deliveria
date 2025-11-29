import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/circular_chart.dart';
import 'package:delveria/features/admin/users/ui/widgets/user_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumbersOfOrdersUserList extends StatelessWidget {
  const NumbersOfOrdersUserList({super.key});

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20),
            SearchRow(showButton: true, isAdmin: false, isAdminUser: false),
            verticalSpace(10),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.sqaureIcon,
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 8),
                        Text(
                    AppStrings.userFilterWithOrder.tr(),
                          style: TextStyles.bimini16W700,
                        ),
                        Spacer(),
                        CircularChart
                        
                        (totalNumbers: 20, isUser: true),
                      ],
                    ),
                    verticalSpace(24),
                    ...AppLists.usersListFilter.map((e) {
                      return Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 15.h),
                        child: UserCard(
                          name: e.name,
                          email: e.email,
                          order: e.orderNum,
                          phone: e.phoneNum, index: 1,
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
  }
}
