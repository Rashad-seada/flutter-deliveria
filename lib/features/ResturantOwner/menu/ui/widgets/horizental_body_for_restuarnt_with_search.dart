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
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
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


class HorizentalBodyForResturantOwnerWithSearch extends StatelessWidget {
  const HorizentalBodyForResturantOwnerWithSearch({
    super.key,
    this.edit,
    this.searchQuery,
    this.isSliver = false,
  });

  final bool? edit;
  final String? searchQuery;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      builder: (context, state) {
        final cubit = context.read<ItemCubit>();

        // Filter items based on search query
        final filteredItems = _filterItems(cubit.allItems, searchQuery);

        // Show "No items found" message if search returns empty results
        if (filteredItems.isEmpty && searchQuery?.isNotEmpty == true) {
          final emptyWidget = Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No items found for "$searchQuery"',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try searching with different keywords',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
          if (isSliver) return SliverToBoxAdapter(child: emptyWidget);
          return emptyWidget;
        }

        if (isSliver) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.56,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= filteredItems.length) {
                   WidgetsBinding.instance.addPostFrameCallback((_) {
                     if (context.mounted) {
                       context.read<ItemCubit>().loadMoreItems();
                     }
                  });
                  return const Center(child: CircularProgressIndicator());
                }
                final item = filteredItems[index];
                return _buildItemCard(context, item, cubit);
              },
              childCount: filteredItems.length + (cubit.hasMoreItems ? 1 : 0),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.56,
          ),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return _buildItemCard(context, item, cubit);
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

  Widget _buildItemCard(BuildContext context, dynamic item, ItemCubit cubit) {
    final size =
        item.sizes != null && item.sizes!.isNotEmpty
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
              (priceBefore?.toString() != null &&
                      priceBefore!.toString().length > 4)
                  ? priceBefore!.toString().substring(0, 4)
                  : priceBefore?.toString() ?? "",
              style: TextStyles.bimini14W700.copyWith(
                decoration: TextDecoration.lineThrough,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              (priceAfter?.toString() != null &&
                      priceAfter!.toString().length > 4)
                  ? priceAfter!.toString().substring(0, 4)
                  : priceAfter?.toString() ?? "",
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
                      (context, url) =>
                          const Center(child: CustomLoading()),
                  errorWidget: (context, url, error) {
                    return const Center(child: CustomLoading());
                  },
                  imageUrl:
                      "${ApiConstants.baseUrl}/${item.photo ?? ""}",
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    item.name ?? AppStrings.classicBurger.tr(),
                    style: TextStyles.bimini16W700,
                  ),
                ),
                edit == true
                    ? Transform.scale(
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
                        },
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 70.h,
              child: Text(
                item.description ?? AppStrings.classicBurgerDes.tr(),
                style: TextStyles.bimini16W400Body.copyWith(
                  color: AppColors.grey,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: priceWidget),
                GestureDetector(child: AddIconContainer(edit: edit)),
                GestureDetector(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _filterItems(List<dynamic>? items, String? searchQuery) {
    if (items == null) return [];
    if (searchQuery == null || searchQuery.isEmpty) return items;

    final query = searchQuery.toLowerCase();
    return items.where((item) {
      // Search in item name, description, and toppings
      final name = item?.name?.toLowerCase() ?? '';
      final description = item?.description?.toLowerCase() ?? '';

      // Check if search query matches name or description
      bool matchesNameOrDescription =
          name.contains(query) || description.contains(query);

      // Check if search query matches any topping name
      bool matchesToppings = false;
      if (item?.toppings != null) {
        // Ensure toppings is a List<ToppingModel>
        final toppingsList = item.toppings;
        if (toppingsList is List) {
          matchesToppings = toppingsList.any((topping) {
            if (topping is ToppingModel) {
              return (topping.topping?.toLowerCase() ?? '').contains(query);
            } else if (topping is Map && topping['name'] != null) {
              return (topping['name'].toString().toLowerCase()).contains(query);
            }
            return false;
          });
        }
      }

      return matchesNameOrDescription || matchesToppings;
    }).toList();
  }
}
