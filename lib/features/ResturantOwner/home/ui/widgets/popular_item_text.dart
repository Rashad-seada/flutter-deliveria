import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/menu_screen.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularItemSection extends StatelessWidget {
  const PopularItemSection({super.key, required this.resId});
  final String resId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => MenuResturantCubit()),
                    BlocProvider(
                      create:
                          (context) =>
                              getIt<ItemCubit>()..getAllItems(resId: resId),
                    ),
                    BlocProvider(
                      create:
                          (context) =>
                              getIt<FilterCategoryCubit>()
                                ..sortByPrice(resId: resId),
                    ),
                  ],
                  child: MenuScreen(),
                ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.popularItem.tr(), style: TextStyles.bimini20W700),
          Row(
            spacing: 4,
            children: [
              Text(
                AppStrings.seeAll.tr(),
                style: TextStyles.bimini14W400White.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Icon(Icons.chevron_right, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
