import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:flutter/material.dart';

class SuperCategorySelectionBody extends StatefulWidget {
  const SuperCategorySelectionBody({
    super.key,
    required this.selectedSuperCategories,
    required this.superCategories, required this.selectedSubCategories, required this.cubit,
  });
  final Map<String, String> selectedSuperCategories;
  final List<SuperCategoryInSuper> superCategories;
  final Map<String, Map<String, String>> selectedSubCategories;
  final AllresturantsadminCubit cubit;

  @override
  State<SuperCategorySelectionBody> createState() =>
      _SuperCategorySelectionBodyState();
}

class _SuperCategorySelectionBodyState
    extends State<SuperCategorySelectionBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: ExpansionTile(
            title: Text(
              widget.selectedSuperCategories.isEmpty
                  ? "Select super categories"
                  : "${widget.selectedSuperCategories.length} super categories selected",
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
                        widget.superCategories.map((superCategory) {
                          final isSelected = widget.selectedSuperCategories
                              .containsKey(superCategory.id);
                          return CheckboxListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 0,
                            ),
                            title: Text(
                              superCategory.nameEn,
                              style: TextStyles.bimini14W500,
                            ),
                            value: isSelected,
                            activeColor: AppColors.primaryDeafult,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  // Add super category
                                  widget.selectedSuperCategories[superCategory
                                          .id] =
                                      superCategory.nameEn;
                                  // Initialize subcategory map for this super category
                               widget.   selectedSubCategories[superCategory.id] = {};
                                } else {
                                  // Remove super category and its subcategories
                                  widget.selectedSuperCategories.remove(
                                    superCategory.id,
                                  );
                                  widget.selectedSubCategories.remove(
                                    superCategory.id,
                                  );
                                }

                                // Update cubit with selected categories
                              widget.  cubit.updateSelectedCategories(
                                  widget.selectedSuperCategories,
                               widget.   selectedSubCategories,
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
        // Show selected super categories as chips
        if (widget.selectedSuperCategories.isNotEmpty) ...[
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
                      widget.selectedSuperCategories.entries.map((entry) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDeafult.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryDeafult.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entry.value,
                                style: TextStyles.bimini12W400Grey.copyWith(
                                  color: AppColors.primaryDeafult,
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.selectedSuperCategories.remove(
                                      entry.key,
                                    );
                               widget.     selectedSubCategories.remove(entry.key);
                                 widget.   cubit.updateSelectedCategories(
                                      widget.selectedSuperCategories,
                                  widget.    selectedSubCategories,
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
    );
  }
}
