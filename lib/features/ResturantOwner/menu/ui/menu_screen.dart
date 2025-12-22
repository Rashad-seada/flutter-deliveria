import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/search_row_with_controller.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_state.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/food_menu_text_resturant.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/get_all_items_bloc_listener.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/horizental_body_for_restuarnt_with_search.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/widgets/vertical_menu_body_for_resturant.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/cubit/item_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, this.resId});
  final String? resId;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

String? _sharedPrefResturantId;

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadResturantId();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Listen to search input changes
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  void _onScroll() {
    // Only handle pagination for Grid View here.
    // List View (VerticalMenuBody) has its own internal controller/scrolling logic.
    final menuCubit = context.read<MenuResturantCubit>();
    if (menuCubit.state.toggleToHorizental) {
       if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        context.read<ItemCubit>().loadMoreItems();
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadResturantId() async {
    final resturantId = await SharedPrefHelper.getString(SharedPrefKeys.resId);
    setState(() {
      _sharedPrefResturantId = resturantId ?? widget.resId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          canPop: false,
          title: AppStrings.restaurantMenue.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<MenuResturantCubit, MenuResturantState>(
        builder: (context, state) {
          return BlocBuilder<FilterCategoryCubit, FilterCategoryState>(
            builder: (context, filterState) {
              final cubit = context.read<FilterCategoryCubit>();
              return RefreshIndicator(
                onRefresh: () async {
                   final itemCubit = context.read<ItemCubit>();
                   await itemCubit.getAllItems(resId: widget.resId ?? _sharedPrefResturantId ?? "");
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            SearchRowWithController(
                              controller: _searchController,
                              showButton: false,
                              showOffers: true,
                              resId: widget.resId ?? _sharedPrefResturantId,
                              sortedPriceItems: cubit.sortedPriceItems,
                            ),
                            verticalSpace(15),
                            FoodMenuTextResturant(state: state),
                            verticalSpace(20),
                          ],
                        ),
                      ),
                    ),
                    state.toggleToHorizental
                        ? SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            sliver: HorizentalBodyForResturantOwnerWithSearch(
                              edit: true,
                              searchQuery: _searchQuery,
                              isSliver: true,
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: VerticalMenuBodyForResturant(
                                edit: true,
                                searchQuery: _searchQuery,
                              ),
                            ),
                          ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

