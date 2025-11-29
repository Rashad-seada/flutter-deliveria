import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_cubit.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_state.dart';
import 'package:delveria/features/admin/users/ui/widgets/filter_dialog_for_admin_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider, ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUserFilter extends StatelessWidget {
  const AdminUserFilter({super.key});

  @override
  Widget build(BuildContext context) {
        return BlocBuilder<AdminUserFilterCubit, AdminUserFilterState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return BlocProvider.value(
                  value: context.read<AdminUserFilterCubit>(),
                  child: FilterDialogForAdminUser(initialSelectedVal: state.selectedVal),
                );
              },
            );
          },
          child: Column(
            children: [
              Image.asset(AppImages.filter, width: 32.w, height: 32.h),
              Text(
                AppStrings.filter.tr(),
                style: TextStyles.bimini14W500.copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
 
  }
}