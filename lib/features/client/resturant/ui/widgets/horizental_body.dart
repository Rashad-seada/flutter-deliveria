import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/add_icon_container.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/edit_your_item.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/add_item_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizentalBodyForUser extends StatefulWidget {
  const HorizentalBodyForUser({
    super.key,
    this.edit,
    this.resId,
    required this.isAdmin,
    this.searchQuery,
    this.isSliver = false,
  });
  final bool? edit;
  final String? resId;
  final bool isAdmin;
  final String? searchQuery;
  final bool isSliver;

  @override
  State<HorizentalBodyForUser> createState() => _HorizentalBodyForUserState();
}

class _HorizentalBodyForUserState extends State<HorizentalBodyForUser> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (!widget.isSliver) {
      _scrollController.addListener(_onScroll);
    }
    // Only load initial items if NOT in sliver mode or if we want to force load.
    // Usually the parent or this widget should trigger load.
    // Keeping this safe:
    context.read<ItemCubit>().getAllItems(resId: widget.resId ?? "");
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<ItemCubit>().loadMoreItems();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        // Ensure toppings is a List<ToppingModel> or Map
        final toppingsList = item.toppings;
        if (toppingsList is List) {
          matchesToppings = toppingsList.any((topping) {
            if (topping is Map && (topping['topping'] != null || topping['name'] != null)) {
              final toppingName = topping['topping'] ?? topping['name'];
              return (toppingName?.toString().toLowerCase() ?? '').contains(query);
            } else if (topping != null && topping is dynamic && topping.topping != null) {
              // Fallback, for other model types
              return (topping.topping?.toString().toLowerCase() ?? '').contains(query);
            }
            return false;
          });
        }
      }

      return matchesNameOrDescription || matchesToppings;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final cubit = context.read<ItemCubit>();
        // Only enabled items
        final allEnabledItems = (cubit.allItems ?? []).where((item) => item.enable != false).toList();

        // Filtered by search
        final enabledItems = _filterItems(allEnabledItems, widget.searchQuery);

        if (state is GetItemLoading && enabledItems.isEmpty) {
          if (widget.isSliver) {
            return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
          }
          return const Center(child: CircularProgressIndicator());
        }

        if (enabledItems.isEmpty) {
          Widget emptyWidget;
          if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
            emptyWidget = Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No items found for "${widget.searchQuery}"',
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
          } else {
            emptyWidget = const Center(child: Text('No items available'));
          }

          if (widget.isSliver) {
            return SliverToBoxAdapter(child: emptyWidget);
          }
          return emptyWidget;
        }

        if (widget.isSliver) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                   if (index >= enabledItems.length) {
                  // Trigger load more when loader becomes visible
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                     if (context.mounted) {
                       context.read<ItemCubit>().loadMoreItems();
                     }
                  });
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final item = enabledItems[index];
                return _buildItemCard(item, cubit);
              },
              childCount: enabledItems.length + (cubit.hasMoreItems ? 1 : 0),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await cubit.getAllItems(resId: widget.resId ?? "",);
          },
            child: GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            physics: widget.isAdmin
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.75,
            ),
            itemCount: enabledItems.length + (cubit.hasMoreItems ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= enabledItems.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    context.read<ItemCubit>().loadMoreItems();
                  }
                });
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final item = enabledItems[index];
              return _buildItemCard(item, cubit);
            },
          ),
        );
      },
    );
  }

  Widget _buildItemCard(dynamic item, ItemCubit cubit) {
    return GestureDetector(
                onTap: widget.isAdmin
                    ? () {}
                    : () {
                        if (cubit.resturant?.isOpen == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Restaurant is Closed"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                        }
                        if (widget.edit == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => MenuResturantCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => getIt<ItemCubit>(),
                                  ),
                                  BlocProvider(
                                    create: (context) => getIt<AllresturantsadminCubit>(),
                                  ),
                                ],
                                child: EditYourItemScreen(
                                  itemImageUrl: "${ApiConstants.baseUrl}/${item.photo ?? ""}",
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
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<ResturantMenuCubit>(
                                    create: (context) => getIt(),
                                  ),
                                  BlocProvider<CarouselCubit>(
                                    create: (context) => getIt(),
                                  ),
                                  BlocProvider.value(value: getIt<AddToCartCubit>()),
                                ],
                                child: AddItemScreen(
                                  item: item,
                                  restaurantModel: cubit.resturant,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                child: item.enable == false
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 147.w,
                                height: 84.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: CachedNetworkImage(
                                    width: 100.w,
                                    height: 100.h,
                                    placeholder: (context, url) => Center(child: CustomLoading()),
                                    errorWidget: (context, url, error) {
                                      return Center(child: CustomLoading());
                                    },
                                    imageUrl: "${ApiConstants.baseUrl}/${item.photo ?? ""}",
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                item.name ?? AppStrings.classicBurger.tr(),
                                style: TextStyles.bimini16W700,
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.description ?? AppStrings.classicBurgerDes.tr(),
                                style: TextStyles.bimini16W400Body.copyWith(
                                  color: AppColors.grey,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Builder(
                                builder: (context) {
                                  final size =
                                      item.sizes?.isNotEmpty == true ? item.sizes!.first : null;
                                  final offer = size?.offer;
                                  final priceAfter = size?.priceAfter;
                                  final priceBefore = size?.priceBefore;

                                  if (offer == null || offer == 100) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${priceAfter?.toString() ?? ""} EGP",
                                          style: TextStyles.bimini16W700,
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          child: AddIconContainer(edit: widget.edit),
                                        ),
                                      ],
                                    );
                                  } else if (offer == 0) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${priceBefore?.toString() ?? ""} EGP",
                                          style: TextStyles.bimini16W700,
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          child: AddIconContainer(edit: widget.edit),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${priceBefore?.toString() ?? ""} EGP",
                                              style: TextStyles.bimini14W700.copyWith(
                                                decoration: TextDecoration.lineThrough,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "${priceAfter?.toString() ?? ""} EGP",
                                              style: TextStyles.bimini16W700,
                                            ),
                                          ],
                                        ),
                                        widget.isAdmin
                                            ? SizedBox()
                                            : GestureDetector(
                                                child: AddIconContainer(
                                                  edit: widget.edit,
                                                ),
                                              ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              );
            }

}

