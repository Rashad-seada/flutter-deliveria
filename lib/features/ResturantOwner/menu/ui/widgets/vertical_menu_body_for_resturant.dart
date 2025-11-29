import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/build_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalMenuBodyForResturant extends StatefulWidget {
  const VerticalMenuBodyForResturant({
    super.key,
    this.showRow,
    this.edit,
    this.searchQuery,
  });

  final bool? showRow;
  final bool? edit;
  final String? searchQuery;

  @override
  State<VerticalMenuBodyForResturant> createState() =>
      _VerticalMenuBodyForResturantState();
}

class _VerticalMenuBodyForResturantState
    extends State<VerticalMenuBodyForResturant> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<ItemCubit>();
    // Only load more if not searching
    if ((widget.searchQuery == null || widget.searchQuery!.isEmpty) &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8) {
      cubit.loadMoreItems();
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
        final filteredItems = _getFilteredItems(allItems);

        // Show loading for initial load
        if (state is GetItemLoading && allItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show "No items found" for search
        if (filteredItems.isEmpty &&
            (widget.searchQuery?.isNotEmpty ?? false)) {
          return Center(
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
        }

        // Show empty state if no items at all
        if (filteredItems.isEmpty) {
          return const Center(child: Text('No items available'));
        }

        final isSearching =
            widget.searchQuery != null && widget.searchQuery!.isNotEmpty;
        final itemCount =
            filteredItems.length +
            ((!isSearching && cubit.hasMoreItems) ? 1 : 0);

        return SizedBox(
          height: 700.h,
          child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // Show loading indicator at bottom when loading more
              if (!isSearching && index >= filteredItems.length) {
                // Pagination loading indicator + test text
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    // Add your test text here
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Pagination loading... (Test Text)',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (index < 0 || index >= filteredItems.length) {
                return const SizedBox.shrink();
              }

              final item = filteredItems[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildMenuItem(
                    true,
                    items: item,
                    context,
                    false,
                    edit: widget.edit,
                    item,
                    showRow: widget.showRow ?? true,
                  ),
                  // Show test text under each paginated item (except last)
                  if (!isSearching &&
                      cubit.hasMoreItems &&
                      index == filteredItems.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Pagination applied successfully (Test Text)',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
