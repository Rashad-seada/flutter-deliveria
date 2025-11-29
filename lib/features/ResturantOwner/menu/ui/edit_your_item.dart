//!see if arabic work 
import 'dart:io';

import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/core/widgets/size_model_to_size_item.dart';
import 'package:delveria/core/widgets/topping_model_to_topping_item.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_state.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/create_item_bloc_listener.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/edit_item_bloc_listener.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/item_name_text_field.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/size_selection_widget.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/toppings_selection_widget.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/upload_photo_container.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/customize_order_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_drop_down/styled_drop_down.dart';

class EditYourItemScreen extends StatefulWidget {
  const EditYourItemScreen({
    super.key,
    required this.isAdd,
    this.itemId,
    this.sizes,
    this.toppings,
    this.itemName,
    this.itemImageUrl,
    this.itemDescription,
  });

  final bool isAdd;
  final String? itemId;
  final List<SizeModel>? sizes;
  final List<ToppingModel>? toppings;
  final String? itemName;
  final String? itemImageUrl;
  final String? itemDescription;

  @override
  State<EditYourItemScreen> createState() => _EditYourItemScreenState();
}

class _EditYourItemScreenState extends State<EditYourItemScreen> {
  bool _initialized = false;
  String? _selectedCategoryId;
  String? _selectedCategoryName;

  // Add a state for the toggle
  bool _haveOption = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final cubit = context.read<ItemCubit>();
      final String currentLang = context.locale.languageCode;

      // Initialize text controllers
      if (!widget.isAdd && widget.itemName != null) {
        cubit.nameController.text = widget.itemName ?? '';
      } else if (widget.isAdd) {
        cubit.nameController.clear();
      }

      if (!widget.isAdd && widget.itemDescription != null) {
        cubit.descriptionController.text = widget.itemDescription ?? '';
      } else if (widget.isAdd) {
        cubit.descriptionController.clear();
      }

      // Initialize sizes and toppings notifiers for edit mode
      if (!widget.isAdd) {
        if (widget.sizes != null && widget.sizes!.isNotEmpty) {
          final convertedSizes =
              widget.sizes!.map((e) => sizeModelToSizeItem(e)).toList();
          cubit.sizesNotifier.value = convertedSizes;
          // Force trigger the callback to ensure everything is synced
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.onSizesChanged(convertedSizes);
          });
        }

        if (widget.toppings != null && widget.toppings!.isNotEmpty) {
          final convertedToppings =
              widget.toppings!
                  .map((e) => toppingModelToToppingItem(e))
                  .toList();
          cubit.toppingsNotifier.value = convertedToppings;
          // Force trigger the callback to ensure everything is synced
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.onToppingsChanged(convertedToppings);
          });
        }
      }

      // Set default selected category if available
      if (widget.isAdd && cubit.allItemsCategories.isNotEmpty) {
        _selectedCategoryId = cubit.allItemsCategories.first.id;
        _selectedCategoryName = currentLang == 'en'
            ? cubit.allItemsCategories.first.nameEn
            : cubit.allItemsCategories.first.nameAr;
        cubit.updateItemCazegoryId(_selectedCategoryId!);
      }

      // Initialize haveOption to false for add mode
      if (widget.isAdd) {
        _haveOption = false;
      }

      _initialized = true;
    }
  }

  bool isNetworkUrl(String? url) {
    if (url == null) return false;
    return url.startsWith('http://') || url.startsWith('https://');
  }

  File createEmptyFile() {
    final tempDir = Directory.systemTemp;
    final tempFile = File(
      '${tempDir.path}/empty_image_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    tempFile.writeAsBytesSync([]);
    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    final String currentLang = context.locale.languageCode;
    return PopScope(
      canPop: widget.isAdd ? false : true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: ArrowBackAppBarWithTitle(
            canPop: widget.isAdd ? false : true,
            reset: false,
            onBack: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CloseAppDialog();
                },
              );
            },
            showTitle: true,
            title:
                widget.isAdd
                    ? AppStrings.addNewItem.tr()
                    : AppStrings.editYourItem.tr(),
            titleStyle: TextStyles.bimini20W700.copyWith(
              color: AppColors.primaryDeafult,
            ),
          ),
        ),
        body: BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
          builder: (context, state) {
            return BlocBuilder<ItemCubit, ItemState>(
              builder: (context, itemState) {
                final cubit = context.read<ItemCubit>();
                final isLoading = itemState is ItemStateLoading;

                // Ensure _selectedCategoryId is always in sync with available categories
                if (widget.isAdd &&
                    cubit.allItemsCategories.isNotEmpty &&
                    (_selectedCategoryId == null ||
                        !cubit.allItemsCategories.any(
                          (cat) => cat.id == _selectedCategoryId,
                        ))) {
                  _selectedCategoryId = cubit.allItemsCategories.first.id;
                  _selectedCategoryName = currentLang == 'en'
                      ? cubit.allItemsCategories.first.nameEn
                      : cubit.allItemsCategories.first.nameAr;
                  cubit.updateItemCazegoryId(_selectedCategoryId!);
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemNameTextField(
                          hint: widget.itemName,
                          itemNameController: cubit.nameController,
                        ),
                        widget.isAdd == false
                            ? SizedBox()
                            : SizedBox(height: 20.h),
                        // Toggle for "spicy and normal option"
                        widget.isAdd
                            ? Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: .8,
                                    child: Switch(
                                      value: _haveOption,
                                      onChanged:
                                          isLoading
                                              ? null
                                              : (val) {
                                                setState(() {
                                                  _haveOption = val;
                                                });
                                              },
                                      activeColor: Colors.white,
                                      activeTrackColor: AppColors.green,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      AppStrings.haveSpicyAndNormalOption.tr(),
                                      style: TextStyles.bimini16W700,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : SizedBox(),
                        widget.isAdd == false
                            ? SizedBox()
                            : Text(
                              AppStrings.uploadPhoto.tr(),
                              style: TextStyles.bimini16W700,
                            ),
                        widget.isAdd == false
                            ? SizedBox()
                            : UploadPhotoContainer(
                              isLogo: false,
                              itemCubit: cubit,
                              itemImage: !widget.isAdd,
                              itemImageUrl: widget.itemImageUrl,
                              onTap:
                                  isLoading
                                      ? null
                                      : () {
                                        cubit.pickPhoto();
                                      },
                            ),
                        SizedBox(height: 20.h),
                        SizedBox(height: 20.h),
                        // Key added to force rebuild when data changes
                        SizeSelectionWidget(
                          key: ValueKey(
                            'sizes_${widget.itemId}_${widget.isAdd}',
                          ),
                          onSizesChanged: (sizes) {
                            print(
                              "📏 SizeSelectionWidget callback triggered with ${sizes.length} sizes",
                            );
                            cubit.sizesNotifier.value = List<SizeItem>.from(
                              sizes,
                            );
                            cubit.onSizesChanged(sizes);
                          },
                          initialSizes: widget.sizes,
                        ),
                        SizedBox(height: 20.h),
                        // Key added to force rebuild when data changes
                        ToppingsSelectionWidget(
                          key: ValueKey(
                            'toppings_${widget.itemId}_${widget.isAdd}',
                          ),
                          onToppingsChanged: (toppings) {
                            print(
                              "🍕 ToppingsSelectionWidget callback triggered with ${toppings.length} toppings",
                            );
                            cubit
                                .toppingsNotifier
                                .value = List<ToppingItem>.from(toppings);
                            cubit.onToppingsChanged(toppings);
                          },
                          initialToppings: widget.toppings,
                        ),
                        SizedBox(height: 20.h),
                        widget.isAdd
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.itemCategory.tr(),
                                  style: TextStyles.bimini20W700,
                                ),
                                SizedBox(height: 8.h),
                                StyledDropDown(
                                  activeColorbtn: AppColors.primaryDeafult,
                                  fillColorbtn: AppColors.primaryDeafult,
                                  value: _selectedCategoryName ?? "",
                                  items: cubit.allItemsCategories
                                      .map((e) => currentLang == 'en' ? e.nameEn : e.nameAr)
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedCategoryName = val as String?;
                                      // Update _selectedCategoryId based on the selected name and language
                                      final selectedCategory = cubit.allItemsCategories.firstWhere(
                                        (cat) => (currentLang == 'en'
                                            ? cat.nameEn
                                            : cat.nameAr) == val,
                                        orElse: () => cubit.allItemsCategories.first,
                                      );
                                      _selectedCategoryId = selectedCategory.id;
                                    });
                                    if (_selectedCategoryId != null) {
                                      cubit.updateItemCazegoryId(
                                        _selectedCategoryId!,
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                            : SizedBox(),
                        verticalSpace(20),
                        Text(
                          AppStrings.customizationOption.tr(),
                          style: TextStyles.bimini20W700,
                        ),
                        BlocBuilder<MenuResturantCubit, MenuResturantState>(
                          builder: (context, state) {
                            return CustomizeOrderTextField(
                              hint: widget.itemDescription,
                              state: state,
                              controller: cubit.descriptionController,
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        widget.isAdd == true
                            ? CreateItemBlocListener(
                              child: Center(
                                child: AppButton(
                                  title: AppStrings.saveChanges.tr(),
                                  onPressed:
                                      isLoading
                                          ? null
                                          : () {
                                            // Pass haveOption to backend
                                            cubit.saveItem(
                                              context,
                                              _haveOption,
                                            );
                                          },
                                ),
                              ),
                            )
                            : EditItemBlocListener(
                              child: Center(
                                child: AppButton(
                                  title: AppStrings.saveChanges.tr(),
                                  onPressed: () async {
                                    print("🚀 Edit button pressed");

                                    // Get current values from notifiers (this is the correct approach)
                                    final List<SizeItem> currentSizes =
                                        cubit.sizesNotifier.value;
                                    final List<ToppingItem> currentToppings =
                                        cubit.toppingsNotifier.value;

                                    print("📊 Current data from notifiers:");
                                    print("   Sizes: ${currentSizes.length}");
                                    for (
                                      int i = 0;
                                      i < currentSizes.length;
                                      i++
                                    ) {
                                      print(
                                        "   Size $i: ${currentSizes[i].sizeController.text} = ${currentSizes[i].priceAfterController.text}",
                                      );
                                    }
                                    print(
                                      "   Toppings: ${currentToppings.length}",
                                    );
                                    for (
                                      int i = 0;
                                      i < currentToppings.length;
                                      i++
                                    ) {
                                      print(
                                        "   Topping $i: ${currentToppings[i].nameController.text} = ${currentToppings[i].priceController.text}",
                                      );
                                    }

                                    File photoToSend;
                                    if (cubit.selectedPhoto != null) {
                                      photoToSend = cubit.selectedPhoto!;
                                    } else {
                                      photoToSend = createEmptyFile();
                                    }

                                    // Get current text from controllers
                                    String itemName =
                                        cubit.nameController.text.trim();
                                    String itemDescription =
                                        cubit.descriptionController.text.trim();

                                    // Only use fallback if completely empty
                                    if (itemName.isEmpty) {
                                      itemName = widget.itemName ?? "";
                                    }
                                    if (itemDescription.isEmpty) {
                                      itemDescription =
                                          widget.itemDescription ?? "";
                                    }

                                    print("📝 Final data to send:");
                                    print("   Name: '$itemName'");
                                    print("   Description: '$itemDescription'");

                                    await cubit.editMenuItem(
                                      itemId: widget.itemId ?? "",
                                      name: itemName,
                                      description: itemDescription,
                                      sizes: currentSizes,
                                      toppings: currentToppings,
                                      // photo: photoToSend,
                                    );
                                  },
                                ),
                              ),
                            ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
