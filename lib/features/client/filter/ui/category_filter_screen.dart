import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart'
    as admin;
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_state.dart';
import 'package:delveria/features/client/filter/ui/widgets/build_empty_state.dart';
import 'package:delveria/features/client/filter/ui/widgets/build_header.dart';
import 'package:delveria/features/client/filter/ui/widgets/categories_container.dart';
import 'package:delveria/features/client/filter/ui/widgets/categories_type.dart';
import 'package:delveria/features/client/filter/ui/widgets/category_resturant_card.dart';
import 'package:delveria/features/client/filter/ui/widgets/get_selected_super_category.dart';
import 'package:delveria/features/client/filter/ui/widgets/get_sub_categories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryFilterScreen extends StatefulWidget {
  const CategoryFilterScreen({super.key, this.lat, this.long, this.isAdmin});
  final double? lat, long;
  final bool? isAdmin;

  @override
  State<CategoryFilterScreen> createState() => _CategoryFilterScreenState();
}

class _CategoryFilterScreenState extends State<CategoryFilterScreen> {
  String? selectedSuperCategoryName;
  String? selectedSubCategoryName;
  bool isFiltering = false;
  bool isInitialized = false;
  bool hasAutoFiltered = false; 

  @override
  void initState() {
    super.initState();
    _loadCategoryPrefs();
  }

  Future<void> _loadCategoryPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedSuperCategoryName = prefs.getString('name');
      isInitialized = true;
    });
  }

  Future<void> _saveSuperCategoryPref(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', value);
  }

  // Add method to handle initial auto-filtering
  void _handleInitialFiltering(CategoryData categoryData) {
    if (!hasAutoFiltered &&
        categoryData.subCategories.isNotEmpty &&
        categoryData.effectiveSubCategoryName != null) {
      hasAutoFiltered = true;

      selectedSubCategoryName = categoryData.effectiveSubCategoryName;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            isFiltering = true;
          });

          widget.isAdmin == true
              ? _filterBySubCategoryAdmin(
                categoryData.effectiveSubCategoryName!,
                categoryData,
              )
              : _filterBySubCategory(
                categoryData.effectiveSubCategoryName!,
                categoryData,
              );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            BlocBuilder<AllresturantsadminCubit, admin.AllresturantsadminState>(
              builder: (context, state) {
                if (state is admin.SuperCateLoading || !isInitialized) {
                  return const CustomLoading();
                }
                return _buildMainContent();
              },
            ),
      ),
    );
  }

  Widget _buildMainContent() {
    final adminCubit = context.read<AllresturantsadminCubit>();
    final categoryData = _getCategoryData(adminCubit);

    if (categoryData.superCategories.isEmpty) {
      return buildEmptyState();
    }

    _handleInitialFiltering(categoryData);

    return BlocConsumer<FilterCategoryCubit, FilterCategoryState>(
      listener: _handleFilterStateChange,
      builder:
          (context, filterState) =>
              _buildContentWithFilter(categoryData, filterState),
    );
  }

  CategoryData _getCategoryData(AllresturantsadminCubit cubit) {
    final superCategories =
        context.locale.languageCode == "en"
            ? cubit.allSuperCategories
                .where((e) => e.nameEn.isNotEmpty)
                .toList()
            : cubit.allSuperCategories
                .where((e) => e.nameAr.isNotEmpty)
                .toList();

    final superCategoryNames =
        context.locale.languageCode == "en"
            ? superCategories.map((e) => e.nameEn).toList()
            : superCategories.map((e) => e.nameAr).toList();

    final effectiveSuperCategoryName = _getEffectiveSuperCategoryName(
      superCategoryNames,
    );

    final selectedSuperCategory = getSelectedSuperCategory(
      superCategories,
      effectiveSuperCategoryName,
      context,
    );

    final subCategories = getSubCategories(selectedSuperCategory, context);

    final effectiveSubCategoryName = _getEffectiveSubCategoryName(
      subCategories,
      selectedSubCategoryName,
      (String? newValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              selectedSubCategoryName = newValue;
            });
          }
        });
      },
    );

    return CategoryData(
      superCategories: superCategories,
      subCategories: subCategories,
      effectiveSuperCategoryName: effectiveSuperCategoryName,
      effectiveSubCategoryName: effectiveSubCategoryName,
      selectedSuperCategory: selectedSuperCategory,
    );
  }

  String? _getEffectiveSubCategoryName(
    List<SubCategory> subCategories,
    String? currentSelected,
    void Function(String? newValue) onReset,
  ) {
    if (subCategories.isEmpty) return null;
    final subCategoryNames =
        context.locale.languageCode == "en"
            ? subCategories.map((e) => e.nameEn).toList()
            : subCategories.map((e) => e.nameAr).toList();

    if (currentSelected != null && subCategoryNames.contains(currentSelected)) {
      return currentSelected;
    } else {
      final first = subCategoryNames.first;
      onReset(first);
      return first;
    }
  }

  String _getEffectiveSuperCategoryName(List<String> superCategoryNames) {
    if (selectedSuperCategoryName != null &&
        superCategoryNames.contains(selectedSuperCategoryName)) {
      return selectedSuperCategoryName!;
    }

    return superCategoryNames.isNotEmpty ? superCategoryNames.first : '';
  }

  void _handleFilterStateChange(
    BuildContext context,
    FilterCategoryState filterState,
  ) {
    if (filterState is Success || filterState is Fail) {
      setState(() => isFiltering = false);
    }
  }

  Widget _buildContentWithFilter(
    CategoryData categoryData,
    FilterCategoryState filterState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        _buildCategories(categoryData),
        _buildRestaurantsList(filterState),
      ],
    );
  }

  Widget _buildCategories(CategoryData categoryData) {
    return Column(
      children: [
        CategoriesContainer(
          superCategories: categoryData.superCategories,
          selectedSuperCategoryName: categoryData.effectiveSuperCategoryName,
          onSuperCategoryChanged:
              (value) => _handleSuperCategoryChange(value, categoryData),
        ),
        CategoriesType(
          subCategories: categoryData.subCategories,
          selectedSubCategoryName: categoryData.effectiveSubCategoryName,
          onSubCategoryChanged:
              (value) => _handleSubCategoryChange(value, categoryData),
        ),
        verticalSpace(10),
      ],
    );
  }

  void _handleSuperCategoryChange(
    String value,
    CategoryData categoryData,
  ) async {
    if (value == selectedSuperCategoryName) return;

    setState(() {
      selectedSuperCategoryName = value;
      selectedSubCategoryName = null;
      isFiltering = false;
      hasAutoFiltered = false; 
    });

    await _saveSuperCategoryPref(value);

    setState(() {});
  }

  void _handleSubCategoryChange(String value, CategoryData categoryData) async {
    if (value == selectedSubCategoryName) return;

    setState(() {
      selectedSubCategoryName = value;
      isFiltering = true;
    });

    widget.isAdmin == true
        ? _filterBySubCategoryAdmin(value, categoryData)
        : _filterBySubCategory(value, categoryData);
  }

  void _filterBySubCategory(String subCategoryName, CategoryData categoryData) {
    final superId = categoryData.selectedSuperCategory.id;
    final subId = _findSubCategoryId(
      subCategoryName,
      categoryData.subCategories,
    );

    if (superId.isNotEmpty && subId != null) {
      final filterCubit = context.read<FilterCategoryCubit>();
      filterCubit.filterByCategory(
        superId: superId,
        subId: subId,
        lat: widget.lat ?? 0,
        long: widget.long ?? 0,
      );
    } else {
      setState(() => isFiltering = false);
    }
  }

  void _filterBySubCategoryAdmin(
    String subCategoryName,
    CategoryData categoryData,
  ) {
    final superId = categoryData.selectedSuperCategory.id;
    final subId = _findSubCategoryId(
      subCategoryName,
      categoryData.subCategories,
    );

    if (superId.isNotEmpty && subId != null) {
      final filterCubit = context.read<AllresturantsadminCubit>();
      filterCubit.filterByCategoryAdmin(superId: superId, subId: subId);
    } else {
      setState(() => isFiltering = false);
    }
  }

  String? _findSubCategoryId(
    String subCategoryName,
    List<SubCategory> subCategories,
  ) {
    try {
      return context.locale.languageCode == "en"
          ? subCategories.firstWhere((e) => e.nameEn == subCategoryName).id
          : subCategories.firstWhere((e) => e.nameAr == subCategoryName).id;
    } catch (_) {
      return null;
    }
  }

  Widget _buildRestaurantsList(FilterCategoryState filterState) {
    if (isFiltering && filterState is Loading) {
      return const Expanded(child: Center(child: CustomLoading()));
    }

    final filterCubit = context.read<FilterCategoryCubit>();
    final filterAdmin = context.read<AllresturantsadminCubit>();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 5,
            childAspectRatio: 0.7,
          ),
          itemCount:
              widget.isAdmin == true
                  ? filterAdmin.categoryResturants.length
                  : filterCubit.resturants.length,
          itemBuilder:
              (context, index) => CategoryRestaurantCard(
                restaurant:
                    widget.isAdmin == true
                        ? filterAdmin.categoryResturants[index]
                        : filterCubit.resturants[index],
              ),
        ),
      ),
    );
  }
}

class CategoryData {
  final List<SuperCategoryInSuper> superCategories;
  final List<SubCategory> subCategories;
  final String effectiveSuperCategoryName;
  final String? effectiveSubCategoryName;
  final SuperCategoryInSuper selectedSuperCategory;

  CategoryData({
    required this.superCategories,
    required this.subCategories,
    required this.effectiveSuperCategoryName,
    required this.effectiveSubCategoryName,
    required this.selectedSuperCategory,
  });
}
