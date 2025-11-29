import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/section_label.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  Map<String, String> selectedSuperCategories = {};
  Map<String, Map<String, String>> selectedSubCategories = {};

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AllresturantsadminCubit>();
    if (cubit.allSuperCategories.isEmpty) {
      cubit.getAllSuperCategories();
    }
  }

  // Helper to get a unique identifier for subcategory
  String _getSubCategoryKey(SubCategory subCategory) {
    if (subCategory.id != null && subCategory.id!.isNotEmpty) {
      return subCategory.id!;
    }
    return "${subCategory.superCategoryId}_${subCategory.nameEn.toLowerCase()}";
  }

  // Remove "All" subcategory from the list
  List<SubCategory> _filterOutAllSubCategory(List<SubCategory> subCategories) {
    return subCategories.where((subCategory) {
      final nameEn = subCategory.nameEn.trim().toLowerCase();
      final nameAr = subCategory.nameAr.trim();
      return nameEn != "all" && nameAr != "الكل";
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String langCode = context.locale.languageCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionLabel(AppStrings.resturantsCategories.tr()),
        verticalSpace(10),
        BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
          builder: (context, state) {
            final cubit = context.read<AllresturantsadminCubit>();

            // Get all super categories
            List<SuperCategoryInSuper> superCategories =
                cubit.allSuperCategories
                    .where((e) => e.nameEn.isNotEmpty)
                    .toList();

            if (superCategories.isEmpty) {
              return Center(
                child: Text(
                  "No valid categories available.",
                  style: TextStyles.bimini16W700.copyWith(
                    color: AppColors.primaryDeafult,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(8),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            selectedSuperCategories.isEmpty
                                ? "Select super categories"
                                : "${selectedSuperCategories.length} super categories selected",
                            style: TextStyles.bimini14W500,
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.primaryDeafult,
                          ),
                          children: [
                            Container(
                              color: Colors.white,
                              constraints: BoxConstraints(maxHeight: 200),
                              child: SingleChildScrollView(
                                child: Column(
                                  children:
                                      superCategories.map((superCategory) {
                                        final isSelected =
                                            selectedSuperCategories.containsKey(
                                              superCategory.id,
                                            );
                                        final superCategoryName =
                                            langCode == "en"
                                                ? superCategory.nameEn
                                                : (superCategory.nameAr);
                                        return CheckboxListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 0,
                                          ),
                                          title: Text(
                                            superCategoryName,
                                            style: TextStyles.bimini14W500,
                                          ),
                                          value: isSelected,
                                          activeColor: AppColors.primaryDeafult,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                // Add super category
                                                selectedSuperCategories[superCategory
                                                        .id] =
                                                    superCategoryName;
                                                // Initialize subcategory map for this super category
                                                selectedSubCategories[superCategory
                                                        .id] =
                                                    {};
                                              } else {
                                                // Remove super category and its subcategories
                                                selectedSuperCategories.remove(
                                                  superCategory.id,
                                                );
                                                selectedSubCategories.remove(
                                                  superCategory.id,
                                                );
                                              }

                                              cubit.updateSelectedCategories(
                                                selectedSuperCategories,
                                                selectedSubCategories,
                                              );
                                            });
                                          },
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (selectedSuperCategories.isNotEmpty) ...[
                      verticalSpace(8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDeafult.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primaryDeafult.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected:",
                              style: TextStyles.bimini12W400Grey.copyWith(
                                color: AppColors.primaryDeafult,
                              ),
                            ),
                            verticalSpace(8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  selectedSuperCategories.entries.map((entry) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryDeafult
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.primaryDeafult
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            entry.value,
                                            style: TextStyles.bimini12W400Grey
                                                .copyWith(
                                                  color:
                                                      AppColors.primaryDeafult,
                                                ),
                                          ),
                                          SizedBox(width: 4),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedSuperCategories.remove(
                                                  entry.key,
                                                );
                                                selectedSubCategories.remove(
                                                  entry.key,
                                                );
                                                cubit.updateSelectedCategories(
                                                  selectedSuperCategories,
                                                  selectedSubCategories,
                                                );
                                              });
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: 14,
                                              color: AppColors.primaryDeafult,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                verticalSpace(20),
                ...selectedSuperCategories.entries.map((entry) {
                  final superId = entry.key;
                  final superName = entry.value;

                  // Find the super category object
                  final superCategoryObj = superCategories.firstWhere(
                    (e) => e.id == superId,
                    orElse: () => superCategories.first,
                  );

                  // Remove "All" subcategory from the list
                  List<SubCategory> subCategories =
                      _filterOutAllSubCategory(
                        superCategoryObj.subCategories
                            .where((e) => e.nameEn.isNotEmpty)
                            .toList(),
                      );

                  if (subCategories.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSectionLabel(
                          "$superName ${AppStrings.resturantSubCategory.tr()}",
                        ),
                        verticalSpace(8),
                        Text(
                          "noSubCate".tr(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        verticalSpace(16),
                      ],
                    );
                  }

                  Map<String, String> currentlySelected =
                      selectedSubCategories[superId] ?? {};

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionLabel(
                        "$superName ${AppStrings.resturantSubCategory.tr()}",
                      ),
                      verticalSpace(8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              currentlySelected.isEmpty
                                  ? "Select subcategories"
                                  : "${currentlySelected.length} subcategories selected",
                              style: TextStyles.bimini14W500,
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primaryDeafult,
                            ),
                            children: [
                              Container(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children:
                                        subCategories.map((subCategory) {
                                          final subKey = _getSubCategoryKey(
                                            subCategory,
                                          );
                                          final isSelected = currentlySelected
                                              .containsKey(subKey);
                                          final subCategoryName =
                                              langCode == "en"
                                                  ? subCategory.nameEn
                                                  : (subCategory.nameAr);

                                          return CheckboxListTile(
                                            dense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 0,
                                                ),
                                            title: Text(
                                              subCategoryName,
                                              style: TextStyles.bimini14W500,
                                            ),
                                            value: isSelected,
                                            activeColor:
                                                AppColors.primaryDeafult,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (value == true) {
                                                  selectedSubCategories[superId] ??= {};
                                                  selectedSubCategories[superId]![subKey] =
                                                      subCategoryName;
                                                } else {
                                                  // Remove subcategory
                                                  selectedSubCategories[superId]
                                                      ?.remove(subKey);

                                                  // Remove empty map if no subcategories selected
                                                  if (selectedSubCategories[superId]
                                                          ?.isEmpty ==
                                                      true) {
                                                    selectedSubCategories[superId] =
                                                        {};
                                                  }
                                                }

                                                // Update cubit
                                                cubit.updateSelectedCategories(
                                                  selectedSuperCategories,
                                                  selectedSubCategories,
                                                );
                                              });
                                            },
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Show selected subcategories as chips
                      if (currentlySelected.isNotEmpty) ...[
                        verticalSpace(8),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDeafult.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryDeafult.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected:",
                                style: TextStyles.bimini12W400Grey.copyWith(
                                  color: AppColors.primaryDeafult,
                                ),
                              ),
                              verticalSpace(8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    currentlySelected.entries.map((entry) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryDeafult
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primaryDeafult
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              entry.value,
                                              style: TextStyles.bimini12W400Grey
                                                  .copyWith(
                                                    color:
                                                        AppColors
                                                            .primaryDeafult,
                                                  ),
                                            ),
                                            SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedSubCategories[superId]
                                                      ?.remove(entry.key);
                                                  if (selectedSubCategories[superId]
                                                          ?.isEmpty ==
                                                      true) {
                                                    selectedSubCategories[superId] =
                                                        {};
                                                  }

                                                  // Update cubit
                                                  cubit
                                                      .updateSelectedCategories(
                                                        selectedSuperCategories,
                                                        selectedSubCategories,
                                                      );
                                                });
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 14,
                                                color: AppColors.primaryDeafult,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                      verticalSpace(16),
                    ],
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}
