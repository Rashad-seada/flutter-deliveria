import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/items_category_model.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemsCategoryScreen extends StatelessWidget {
  AddItemsCategoryScreen({super.key});
  final TextEditingController nameEn = TextEditingController();
  final TextEditingController nameAr = TextEditingController();

  List<ItemCategory> allItemsCategory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: AppStrings.addItemCategories.tr(),
          canPop: true,
          onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          if (state is GetItemsCategoriesSuccess) {
            allItemsCategory = state.data.itemCategories;
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(20),
                  CustomFormW(
                    spacing: 20,
                    showButton: false,
                    padding: EdgeInsetsGeometry.zero,
                    children: [
                      CustomTextField(
                        controller: nameEn,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hint: AppStrings.englishNameOfItemCategory.tr(),
                        hintStyle: TextStyles.bimini12W400Grey,
                      ),
                      CustomTextField(
                        controller: nameAr,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hint: AppStrings.arabicNameOfItemCategory.tr(),
                        hintStyle: TextStyles.bimini12W400Grey,
                      ),
                    ],
                  ),
                  BlocConsumer<ItemCubit, ItemState>(
                    builder: (context, state) {
                      if (state is CreateItemCategoriesLoading) {
                        return CustomLoading();
                      }
                      final cubit = context.read<ItemCubit>();
                      return AppButton(
                        title: AppStrings.add.tr(),
                        onPressed: () {
                          cubit.createItemCategories(
                            body: {
                              "name_en": nameEn.text,
                              "name_ar": nameAr.text,
                            },
                          );
                        },
                      );
                    },
                    listener: (BuildContext context, ItemState state) {
                      final cubit = context.read<ItemCubit>();
                      state.whenOrNull(
                        createItemCategoriesSuccess: (data) {
                          showSuccessSnackBar(context, AppStrings.success.tr());
                          cubit.getItemCategories();
                          nameAr.clear();
                          nameEn.clear();
                        },
                      );
                    },
                  ),
                  verticalSpace(20),
                  if (allItemsCategory.isNotEmpty)
                    ...allItemsCategory.asMap().entries.map((e) {
                      // e.key is the index, e.value is the ItemCategory
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${e.value.nameEn} / ${e.value.nameAr}',
                              style: TextStyles.bimini14W500,
                            ),
                            // Add more widgets as needed
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
