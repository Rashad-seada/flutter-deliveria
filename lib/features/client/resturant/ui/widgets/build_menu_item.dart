import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/edit_your_item.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/add_item_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Global flag to prevent multiple snackbars
bool _isDeleteSnackBarShown = false;

Widget buildMenuItem(
  bool isRes,
  BuildContext context,
  bool isAdmin,
  ItemModel item, {
  bool showRow = true,
  bool? edit = false,
  ItemModel? items,
  RestaurantModel? res,
}) {
  if (isRes == false && item.enable == false) {
    return SizedBox();
  }

  return GestureDetector(
    onTap:
        isAdmin
            ? () {}
            : () {
              if (edit == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => MenuResturantCubit(),
                            ),
                            BlocProvider(
                              create: (context) => getIt<ItemCubit>(),
                            ),
                            BlocProvider(
                              create:
                                  (context) => getIt<AllresturantsadminCubit>(),
                            ),
                            BlocProvider<AddToCartCubit>(
                              create: (context) => getIt(),
                            ),
                          ],
                          child: EditYourItemScreen(
                            itemImageUrl:
                                "${ApiConstants.baseUrl}/${item.photo ?? ""}",
                            itemDescription: item.description,
                            isAdd: false,
                            itemId: item.id,
                            itemName: item.name,
                            sizes: item.sizes,
                            toppings: item.toppings ?? [],
                          ),
                        ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider<ResturantMenuCubit>(
                              create: (context) => getIt(),
                            ),
                            BlocProvider<CarouselCubit>(
                              create: (context) => getIt(),
                            ),
                            BlocProvider<AddToCartCubit>(
                              create: (context) => getIt(),
                            ),
                          ],
                          child: AddItemScreen(
                            item: items,
                            restaurantModel: res,
                          ),
                        ),
                  ),
                );
              }
            },
    child: Container(
      margin: EdgeInsets.only(bottom: showRow ? 16 : 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 112.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Align(
              alignment: Alignment.topLeft,
              child: CachedNetworkImage(
                width: 100.w,
                height: 100.h,
                imageUrl: "${ApiConstants.baseUrl}/${item.photo}",
                placeholder: (context, url) => Center(child: CustomLoading()),
                errorWidget: (context, url, error) {
                  return Center(child: CustomLoading());
                },
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: Text(
                        item.name ?? "",
                        style: TextStyles.bimini16W700,
                      ),
                    ),
                    edit == true
                        ? BlocBuilder<ItemCubit, ItemState>(
                          builder: (context, state) {
                            final cubit = context.read<ItemCubit>();
                            return Transform.scale(
                              scale: .5,
                              child: Switch(
                                activeColor: Colors.white,
                                activeTrackColor: AppColors.green,
                                value: item.enable ?? false,
                                onChanged: (val) async {
                                  print("enter to change enable ");
                                  await cubit.changeEnableItem(
                                    itemId: item.id ?? "",
                                    resId: item.restaurantId ?? "",
                                  );
                                  // await cubit.getAllItems(
                                  //   resId: item?.restaurantId ?? "",
                                  // );
                                },
                              ),
                            );
                          },
                        )
                        : SizedBox(),
                  ],
                ),
                verticalSpace(5),
                Text(
                  item.description ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bimini16W400Body.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 8),
                showRow == true
                    ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 10.w,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Custom price logic based on offer
                          Builder(
                            builder: (context) {
                              final size = item.sizes?.first;
                              final offer = size?.offer;
                              final priceAfter = size?.priceAfter;
                              final priceBefore = size?.priceBefore;

                              if (offer == null || offer == 100) {
                                // If offer is null, show priceAfter only
                                return SizedBox(
                                  width: edit == true ? 120.w : 170.w,
                                  child: Text(
                                    "${priceAfter?.toString() ?? ""} EGP",
                                    style: TextStyles.bimini16W700,
                                  ),
                                );
                              } else if (offer == 0) {
                                // If offer is zero, show priceBefore only
                                return SizedBox(
                                  width: edit == true ? 120.w : 150.w,
                                  child: Text(
                                    "${priceBefore?.toString() ?? ""} EGP",
                                    style: TextStyles.bimini16W700,
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  width: edit == true ? 140.w : 130.w,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${priceBefore.toString().length > 4 ? priceBefore?.toString().substring(0, 4) : priceBefore?.toString() ?? ""} EGP",
                                        style: TextStyles.bimini14W700.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${priceAfter.toString().length > 4 ? priceAfter?.toString().substring(0, 4) : priceAfter?.toString() ?? ""} EGP",
                                        style: TextStyles.bimini16W700,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          isAdmin
                              ? SizedBox()
                              : GestureDetector(
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDeafult,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    edit == true ? Icons.edit : Icons.add,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                          edit == true
                              ? BlocConsumer<ItemCubit, ItemState>(
                                listener: (context, state) {
                                  final cubit = context.read<ItemCubit>();
                                  if (state is DeleteItemSuccess) {
                                    // Prevent multiple snackbars
                                    if (!_isDeleteSnackBarShown) {
                                      _isDeleteSnackBarShown = true;
                                      showSuccessSnackBar(
                                        context,
                                        "Item Deleted successfully",
                                      );
                                      Future.delayed(
                                        const Duration(milliseconds: 500),
                                        () {
                                          _isDeleteSnackBarShown = false;
                                        },
                                      );
                                    }
                                    cubit.getAllItems(
                                      resId: cubit.resturant?.id ?? "",
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  final cubit = context.read<ItemCubit>();
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  AppStrings.areYouSureToDelete
                                                      .tr(),
                                                  style: TextStyles.bimini16W700
                                                      .copyWith(
                                                        color:
                                                            AppColors
                                                                .primaryDeafult,
                                                      ),
                                                ),
                                                verticalSpace(20),
                                                TrackOrderButtonRow(
                                                  ftitle:
                                                      AppStrings.delete.tr(),
                                                  sTitle:
                                                      AppStrings.cancel.tr(),
                                                  sOnPressed: () {
                                                    context.pop();
                                                  },
                                                  fOnPressed: () async {
                                                    await cubit.deleteItem(
                                                      itemId: item.id ?? "",
                                                    );
                                                    context.pop();
                                                  },
                                                  fWidth: 130.w,
                                                  sWidth: 90.w,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.asset(
                                      AppImages.trach,
                                      width: 24.w,
                                      height: 24.h,
                                      color: AppColors.primaryDeafult,
                                    ),
                                  );
                                },
                              )
                              : SizedBox(),
                        ],
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
