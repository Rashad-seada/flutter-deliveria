import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/add_icon_container.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/edit_your_item.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/payment/ui/widgets/track_order_button_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizentalBodyForResturantOwner extends StatelessWidget {
  const HorizentalBodyForResturantOwner({super.key, this.edit});
  final bool? edit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      builder: (context, state) {
        final cubit = context.read<ItemCubit>();
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.75,
          ),
          itemCount: cubit.allItems?.length ?? 0,
          itemBuilder: (context, index) {
            final item = cubit.allItems?[index];
            final size =
                item?.sizes != null && item!.sizes!.isNotEmpty
                    ? item.sizes!.first
                    : null;
            final offer = size?.offer;
            final priceBefore = size?.priceBefore;
            final priceAfter = size?.priceAfter;

            Widget priceWidget = const SizedBox();

            if (size != null) {
              if (offer == null || offer == 100) {
                priceWidget = Text(
                  priceAfter?.toString() ?? "",
                  style: TextStyles.bimini16W700,
                );
              } else if (offer == 0) {
                priceWidget = Text(
                  priceBefore?.toString() ?? "",
                  style: TextStyles.bimini16W700,
                );
              } else {
                priceWidget = Row(
                  children: [
                    Text(
                      priceBefore?.toString() ?? "",
                      style: TextStyles.bimini14W700.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      priceAfter?.toString() ?? "",
                      style: TextStyles.bimini16W700,
                    ),
                  ],
                );
              }
            }

            return GestureDetector(
              onTap: () {
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
                                    (context) =>
                                        getIt<AllresturantsadminCubit>(),
                              ),
                            ],
                            child: EditYourItemScreen(
                              itemImageUrl:
                                  "${ApiConstants.baseUrl}/${item?.photo ?? ""}",
                              itemDescription: item?.description,
                              isAdd: false,
                              itemId: item?.id,
                              itemName: item?.name,
                              sizes: item?.sizes == null ? null : item!.sizes,
                              toppings: item?.toppings ?? [],
                            ),
                          ),
                    ),
                  );
                } else {
                  context.pushNamed(Routes.addItemScreen);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 84.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CachedNetworkImage(
                          width: 100.w,
                          height: 100.h,
                          placeholder:
                              (context, url) => Center(child: CustomLoading()),
                          errorWidget: (context, url, error) {
                            return Center(child: CustomLoading());
                          },
                          imageUrl:
                              "${ApiConstants.baseUrl}/${item?.photo ?? ""}",
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            item?.name ?? AppStrings.classicBurger.tr(),
                            style: TextStyles.bimini16W700,
                          ),
                        ),
                        edit == true
                            ? Transform.scale(
                              scale: .5,
                              child: Switch(
                                activeColor: Colors.white,
                                activeTrackColor: AppColors.green,
                                value: item?.enable ?? false,
                                onChanged: (val) async {
                                  print("enter to change enable ");
                                  await cubit.changeEnableItem(
                                    itemId: item?.id ?? "",
                                    resId: item?.restaurantId??"",
                                  );
                               
                                },
                              ),
                            )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      item?.description ?? AppStrings.classicBurgerDes.tr(),
                      style: TextStyles.bimini16W400Body.copyWith(
                        color: AppColors.grey,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: priceWidget),
                        GestureDetector(child: AddIconContainer(edit: edit)),
                        GestureDetector(
                          onTap: () {
                            //!check if work after server back
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppStrings.areYouSureToDelete.tr(),
                                        style: TextStyles.bimini16W700.copyWith(
                                          color: AppColors.primaryDeafult,
                                        ),
                                      ),
                                      verticalSpace(20),
                                      TrackOrderButtonRow(
                                        ftitle: AppStrings.delete.tr(),
                                        sTitle: AppStrings.cancel.tr(),
                                        sOnPressed: () {
                                          context.pop();
                                        },
                                        fOnPressed: () async {
                                          await cubit.deleteItem(
                                            itemId: item?.id ?? "",
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      listener: (context, state) {
        if (state is DeleteItemSuccess) {
          final cubit = context.read<ItemCubit>();
          showSuccessSnackBar(context, "Item Deleted successfully");
          cubit.getAllItems(resId: cubit.resturant?.id ?? "");
        }
      },
    );
  }
}
