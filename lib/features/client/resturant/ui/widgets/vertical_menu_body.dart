import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/build_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerticalMenuBody extends StatefulWidget {
  const VerticalMenuBody({
    super.key,
    this.showRow,
    this.edit,
    this.resId,
    required this.isAdmin,
    this.searchQuery,
    this.isSliver = false,
  });
  final bool? showRow;
  final bool? edit;
  final String? resId;
  final bool isAdmin;
  final String? searchQuery;
  final bool isSliver;

  @override
  State<VerticalMenuBody> createState() => _VerticalMenuBodyState();
}

class _VerticalMenuBodyState extends State<VerticalMenuBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Initial load attempt (safe to call multiple times if handled by cubit)
    context.read<ItemCubit>().getAllItems(
      resId: widget.resId ?? "",
    );

    if (!widget.isSliver) {
      // Add scroll listener for pagination only if NOT using external controller
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    // Only load more if not searching
    if ((widget.searchQuery == null || widget.searchQuery!.isEmpty) &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
      context.read<ItemCubit>().loadMoreItems();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<ItemModel> _getFilteredItems(List<ItemModel>? allItems) {
    if (widget.searchQuery == null || widget.searchQuery!.isEmpty) {
      return allItems ?? [];
    }
    final query = widget.searchQuery!.toLowerCase();
    return (allItems ?? []).where((item) {
      final name = item.name?.toLowerCase() ?? '';
      final description = item.description?.toLowerCase() ?? '';
      bool matchesNameOrDescription =
          name.contains(query) || description.contains(query);
      bool matchesToppings = false;
      if (item.toppings != null) {
        matchesToppings = item.toppings!.any(
          (topping) => topping.topping?.toLowerCase().contains(query) ?? false,
        );
      }
      return matchesNameOrDescription || matchesToppings;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final cubit = context.read<ItemCubit>();
        final allItems = cubit.allItems ?? [];
        final items = _getFilteredItems(allItems);
        int filteredItemCount;

        // If showRow==false, only show 4
        if (widget.showRow == false) {
          filteredItemCount = items.length < 4 ? items.length : 4;
        } else {
          filteredItemCount = items.length;
        }

        // Show loading for initial load
        if (state is GetItemLoading && allItems.isEmpty) {
          if (widget.isSliver) {
            return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
          }
          return const Center(child: CircularProgressIndicator());
        }

        // Show "No items found" for search
        if (items.isEmpty && (widget.searchQuery?.isNotEmpty ?? false)) {
          Widget emptyWidget = Center(
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
          if(widget.isSliver) {
            return SliverToBoxAdapter(child: emptyWidget);
          }
          return emptyWidget;
        }

        if (filteredItemCount == 0) {
          if (widget.isSliver) {
            return const SliverToBoxAdapter(child: Center(child: Text('No items available')));
          }
          return const Center(child: Text('No items available'));
        }

        final isSearching =
            widget.searchQuery != null && widget.searchQuery!.isNotEmpty;
        final itemCount = filteredItemCount +
            ((!isSearching &&
                    cubit.hasMoreItems &&
                    widget.showRow != false)
                ? 1
                : 0);
        
        if (widget.isSliver) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                 if (!isSearching &&
                    cubit.hasMoreItems &&
                    index >= filteredItemCount) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (index < 0 || index >= filteredItemCount) {
                  return const SizedBox.shrink();
                }

                final item = items[index];
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: buildMenuItem(
                      false,
                      items: item,
                      res: cubit.resturant,
                      context,
                      widget.isAdmin,
                      edit: widget.edit,
                      item,
                      showRow: widget.showRow ?? true,
                    ));
              },
              childCount: itemCount,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await cubit.getAllItems(resId: widget.resId ?? "");
          },
          child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: widget.isAdmin
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // Show loading indicator at the bottom (pagination)
              if (!isSearching &&
                  cubit.hasMoreItems &&
                  index >= filteredItemCount) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (index < 0 || index >= filteredItemCount) {
                return const SizedBox.shrink();
              }

              final item = items[index];
              return buildMenuItem(
                false,
                items: item,
                res: cubit.resturant,
                context,
                widget.isAdmin,
                edit: widget.edit,
                item,
                showRow: widget.showRow ?? true,
              );
            },
          ),
        );
      },
    );
  }
}
