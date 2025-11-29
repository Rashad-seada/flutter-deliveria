import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/filter/ui/category_filter_screen.dart';
import 'package:delveria/features/client/home/ui/widgets/close_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatefulWidget {
  final int initialSelectedVal;
  const FilterDialog({super.key, required this.initialSelectedVal});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late int tempSelectedVal;

  @override
  void initState() {
    super.initState();
    tempSelectedVal = widget.initialSelectedVal;
  }

  void _handleApplyChanges(BuildContext context) {
    context.read<AdminResturantFilterCubit>().updateSelected(
      newSelected: tempSelectedVal,
    );
    if (tempSelectedVal == 0) {
      Navigator.of(context).pop(); 
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) =>
                            getIt<AllresturantsadminCubit>()
                              ..getAllSuperCategories(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<FilterCategoryCubit>(),
                  ),
                ],
                child: CategoryFilterScreen(isAdmin: true),
              ),
        ),
      );
    } else if (tempSelectedVal == 1) {
      Navigator.of(context).pop(); // Close the dialog first
      context.pushNamed(Routes.adminTopRatedFilter);
    } else {
      Navigator.of(context).pop(); // Just close the dialog
    }
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
            title: Text(AppStrings.categories.tr(), style: TextStyles.bimini16W700),
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
            title: Text(AppStrings.topRated.tr(), style: TextStyles.bimini16W700),
            value: 1,
            groupValue: tempSelectedVal,
            onChanged: (p) {
              setState(() {
                tempSelectedVal = p!;
              });
            },
          ),
          AppButton(
            title: AppStrings.applyChanges.tr(),
            onPressed: () => _handleApplyChanges(context),
          ),
        ],
      ),
    );
  }
}
