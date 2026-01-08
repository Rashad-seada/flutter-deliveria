import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/filter/ui/category_filter_screen.dart';
import 'package:delveria/features/client/filter/ui/widgets/categories_container.dart';
import 'package:delveria/features/client/home/ui/widgets/shared/empty_restaurants_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Categories section with super category chips
class HomeCategoriesSection extends StatelessWidget {
  final double lat;
  final double long;
  final String? selectedCategoryName;

  const HomeCategoriesSection({
    super.key,
    required this.lat,
    required this.long,
    this.selectedCategoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        if (state is SuperCateLoading) {
          return CustomLoading();
        }

        final superCategories = context.read<AllresturantsadminCubit>().allSuperCategories;

        if (superCategories.isEmpty) {
          return const EmptyRestaurantsWidget();
        }

        return CategoriesContainer(
          superCategories: superCategories,
          selectedSuperCategoryName: selectedCategoryName ?? "",
          onSuperCategoryChanged: (selectedName) => _onCategorySelected(context, selectedName),
        );
      },
    );
  }

  Future<void> _onCategorySelected(BuildContext context, String selectedName) async {
    await SharedPrefHelper.setData("name", selectedName);
    
    if (!context.mounted) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<AllresturantsadminCubit>()),
            BlocProvider(create: (context) => getIt<FilterCategoryCubit>()),
          ],
          child: CategoryFilterScreen(
            lat: lat,
            long: long,
            isAdmin: false,
          ),
        ),
      ),
    );
  }
}
