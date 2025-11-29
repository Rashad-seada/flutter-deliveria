import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialogForAdminUser extends StatefulWidget {
  const FilterDialogForAdminUser({super.key, required this.initialSelectedVal});
    final int initialSelectedVal;


  @override
  State<FilterDialogForAdminUser> createState() => _FilterDialogForAdminUserState();
}

class _FilterDialogForAdminUserState extends State<FilterDialogForAdminUser> {
    late int tempSelectedVal;

  @override
  void initState() {
    super.initState();
    tempSelectedVal = widget.initialSelectedVal;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      icon: CloseIcon(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.selectYourFilter.tr(),
            style: TextStyles.bimini20W700.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          verticalSpace(10),
          RadioListTile<int>(
            activeColor: AppColors.primaryDeafult,
            title: Text(AppStrings.numberOfOrders.tr(), style: TextStyles.bimini16W700),
            value: 0,
            groupValue: tempSelectedVal,
            onChanged: (p) {
              setState(() {
                tempSelectedVal = p!;
              });
            },
          ),
          RadioListTile<int>(
            activeColor: AppColors.primaryDeafult,
            title: Text(AppStrings.moneySpent.tr(), style: TextStyles.bimini16W700),
            value: 1,
            groupValue: tempSelectedVal,
            onChanged: (p) {
              setState(() {
                tempSelectedVal = p!;
              });
            },
          ),
          RadioListTile<int>(
            activeColor: AppColors.primaryDeafult,
            title: Text(AppStrings.resetAdded.tr(), style: TextStyles.bimini16W700),
            value: 2,
            groupValue: tempSelectedVal,
            onChanged: (p) {
              setState(() {
                tempSelectedVal = p!;
              });
            },
          ),
          AppButton(
            title: AppStrings.applyChanges.tr(),
            onPressed: () {
              context.read<AdminUserFilterCubit>().updateSelectedVal(
                newVal: tempSelectedVal,
              );
              Navigator.of(context).pop();
              if (tempSelectedVal == 0) {
                context.pushNamed(Routes.numberOfOrdersUsersList);
              } 
            },
          ),
        ],
      ),
    );
  
  }
}