import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/client/cart/data/models/add_to_cart_request.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/add_to_cart_bloc_listener.dart';
import 'package:delveria/features/client/resturant/ui/widgets/customize_order_text_field.dart';
import 'package:delveria/features/client/resturant/ui/widgets/require_size_list.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key, this.item, this.restaurantModel});
  final ItemModel? item;
  final RestaurantModel? restaurantModel;

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  List<String> selectedToppingIds = [];
  String? selectedNecessaryToppingId;
  String? selectedOption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(showTitle: false , 
          onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
        ),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
              builder: (context, state) {
                String? selectedSizeId;
                if (widget.item?.sizes != null &&
                    widget.item!.sizes!.isNotEmpty) {
                  final selectedSize =
                      widget.item!.sizes!
                          .where((size) => size.size == state.selectedSize)
                          .toList();
                  if (selectedSize.isNotEmpty) {
                    selectedSizeId = selectedSize.first.id;
                  }
                }

                List<ToppingModel> necessaryToppings = [];
                List<ToppingModel> normalToppings = [];
                if (widget.item?.toppings != null &&
                    widget.item!.toppings!.isNotEmpty) {
                  for (final topping in widget.item!.toppings!) {
                    if ((topping.price ?? 0) == 0) {
                      necessaryToppings.add(topping);
                    } else {
                      normalToppings.add(topping);
                    }
                  }
                }

                List<ToppingRequest> selectedToppings = [];
                if (selectedNecessaryToppingId != null) {
                  selectedToppings.add(
                    ToppingRequest(topping: selectedNecessaryToppingId!),
                  );
                }
                for (final topping in normalToppings) {
                  if (selectedToppingIds.contains(topping.id)) {
                    selectedToppings.add(ToppingRequest(topping: topping.id!));
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.item?.photo != null
                        ? CachedNetworkImage(
                          placeholder:
                              (context, url) => Center(child: CustomLoading()),
                          errorWidget: (context, url, error) {
                            return Center(child: CustomLoading());
                          },
                          imageUrl:
                              "${ApiConstants.baseUrl}/${widget.item?.photo}",
                        )
                        : Image.asset(AppImages.resturantImage),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            widget.item?.name != null
                                ? widget.item!.name!
                                : AppStrings.classicBurger.tr(),
                            style: TextStyles.bimini20W700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item?.description != null
                          ? widget.item!.description!
                          : AppStrings.classicBurgerDes.tr(),
                      style: TextStyles.bimini16W400Body.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.requireSize.tr(),
                      style: TextStyles.bimini20W700,
                    ),
                    verticalSpace(20),
                    RequiredSizeList(
                      state: state,
                      themeState: themeState,
                      item: widget.item,
                    ),
                    verticalSpace(20),
                    if (widget.item?.haveOption == true) ...[
                      Text(
                        AppStrings.chooseOption.tr(),
                        style: TextStyles.bimini20W700,
                      ),
                      verticalSpace(10),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              value: AppStrings.spicy.tr(),
                              groupValue: selectedOption,
                              onChanged: (val) {
                                setState(() {
                                  selectedOption = val;
                                });
                              },
                              title: Text(
                                AppStrings.spicy.tr(),
                                style: TextStyles.bimini16W400Body.copyWith(
                                  color:
                                      selectedOption == AppStrings.spicy.tr()
                                          ? AppColors.primaryDeafult
                                          : themeState.themeMode ==
                                              ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              activeColor: AppColors.primary,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              value: AppStrings.normal.tr(),
                              groupValue: selectedOption,
                              onChanged: (val) {
                                setState(() {
                                  selectedOption = val;
                                });
                              },
                              title: Text(
                                AppStrings.normal.tr(),
                                style: TextStyles.bimini16W400Body.copyWith(
                                  color:
                                      selectedOption == AppStrings.normal.tr()
                                          ? AppColors.primaryDeafult
                                          : themeState.themeMode ==
                                              ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              activeColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(24),
                    ],

                    // Necessary toppings group (price == 0)
                    if (necessaryToppings.isNotEmpty) ...[
                      Text(
                        AppStrings.neccessaryToppings.tr(),
                        style: TextStyles.bimini20W700,
                      ),
                      verticalSpace(12),
                      Column(
                        children:
                            necessaryToppings.map((topping) {
                              return RadioListTile<String>(
                                value: topping.id ?? "",
                                groupValue: selectedNecessaryToppingId,
                                onChanged: (val) {
                                  setState(() {
                                    selectedNecessaryToppingId = val;
                                  });
                                },
                                title: Text(
                                  topping.topping ?? "",
                                  style: TextStyles.bimini16W400Body.copyWith(
                                    color:
                                        selectedNecessaryToppingId == topping.id
                                            ? AppColors.primaryDeafult
                                            : themeState.themeMode ==
                                                ThemeMode.dark
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                activeColor: AppColors.primary,
                              );
                            }).toList(),
                      ),
                      verticalSpace(20),
                    ],
                    Text(
                      AppStrings.desireToppings.tr(),
                      style: TextStyles.bimini20W700,
                    ),
                    verticalSpace(20),
                    // --- Multi-topping selection with checkboxes for normal toppings ---
                    if (normalToppings.isNotEmpty)
                      Column(
                        children:
                            normalToppings.map((topping) {
                              final isChecked = selectedToppingIds.contains(
                                topping.id,
                              );
                              return CheckboxListTile(
                                value: isChecked,

                                onChanged: (checked) {
                                  setState(() {
                                    if (checked == true) {
                                      if (!selectedToppingIds.contains(
                                        topping.id,
                                      )) {
                                        selectedToppingIds.add(topping.id!);
                                      }
                                    } else {
                                      selectedToppingIds.remove(topping.id);
                                    }
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      topping.topping ?? "",
                                      style: TextStyles.bimini16W400Body
                                          .copyWith(
                                            color:
                                                isChecked
                                                    ? AppColors.primaryDeafult
                                                    : themeState.themeMode ==
                                                        ThemeMode.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                    ),

                                    Text(
                                      "${topping.price.toString()} L.E",
                                      style: TextStyles.bimini16W400Body
                                          .copyWith(
                                            color:
                                                isChecked
                                                    ? AppColors.primaryDeafult
                                                    : themeState.themeMode ==
                                                        ThemeMode.dark
                                                    ? Colors.white
                                                    : Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: AppColors.primary,
                              );
                            }).toList(),
                      )
                    else
                      Text(
                        AppStrings.noToppingsAvailable.tr(),
                        style: TextStyles.bimini16W400Body.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    verticalSpace(30),
                    Text(
                      AppStrings.customizationOption.tr(),
                      style: TextStyles.bimini20W700,
                    ),
                    verticalSpace(20),
                    CustomizeOrderTextField(
                      state: state,
                      controller: state.customizationController,
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<CarouselCubit, CarouselState>(
                      builder: (context, cState) {
                        return BlocBuilder<AddToCartCubit, AddToCartState>(
                          builder: (context, cartState) {
                            final addToCartCubit =
                                context.read<AddToCartCubit>();
                            return AddToCartBlocListener(
                              newIndex: cState.selectedIndex + 1,
                              child: Center(
                                child: BlocBuilder<
                                  CarouselCubit,
                                  CarouselState
                                >(
                                  builder: (context, carouselState) {
                                    return AppButton(
                                      title: AppStrings.addToCart.tr(),
                                      onPressed: () async {
                                        await SharedPrefHelper.setData(
                                          SharedPrefKeys.onlineGuest,
                                          false,
                                        );
                                        final newIndex =
                                            carouselState.selectedIndex + 1;

                                        // If no size is selected, show warning and do not proceed
                                        if (selectedSizeId == null ||
                                            selectedSizeId.isEmpty) {
                                          showWarningSnackBar(
                                            context,
                                            AppStrings.pleaseSelectSize.tr(),
                                          );
                                          return;
                                        }

                                        //  item has option
                                        if (widget.item?.haveOption == true &&
                                            (selectedOption == null ||
                                                selectedOption!.isEmpty)) {
                                          showWarningSnackBar(
                                            context,
                                            "Please select an option (Spicy or Normal)",
                                          );
                                          return;
                                        }

                                        // If necessary toppings exist, validate selection
                                        if (necessaryToppings.isNotEmpty &&
                                            (selectedNecessaryToppingId ==
                                                    null ||
                                                selectedNecessaryToppingId!
                                                    .isEmpty)) {
                                          showWarningSnackBar(
                                            context,
                                            "Please select a necessary topping",
                                          );
                                          return;
                                        }

                                        // Debug prints
                                        print(
                                          "Selected Size ID: $selectedSizeId",
                                        );
                                        print(
                                          "Selected Toppings: ${selectedToppings.map((t) => t.topping).toList()}",
                                        );
                                        print(
                                          "Selected Option: $selectedOption",
                                        );
                                        print(
                                          "Selected Necessary Topping: $selectedNecessaryToppingId",
                                        );

                                        addToCartCubit.addToCart(
                                          addToCart: AddToCartRequest(
                                            restaurantId:
                                                widget.restaurantModel?.id ??
                                                "",
                                            itemId: widget.item?.id ?? "",
                                            size: selectedSizeId ?? "",
                                            toppings: selectedToppings,
                                            description:
                                                "${state.customizationController.text} ${widget.item?.haveOption == true ? selectedOption : null}",
                                          ),
                                        );
                                        print(newIndex);
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    verticalSpace(20),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
