import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/best_picks_body.dart';
import 'package:delveria/features/client/resturant/ui/widgets/best_picks_text_row.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopPicksSection extends StatefulWidget {
  final String restaurantId;
  final ThemeState themeState;

  const TopPicksSection({
    super.key,
    required this.restaurantId,
    required this.themeState,
  });

  @override
  State<TopPicksSection> createState() => _TopPicksSectionState();
}

class _TopPicksSectionState extends State<TopPicksSection> {
  // We use a separate ItemCubit for fetching top picks to avoid conflict with other cubits
  late ItemCubit _itemCubit;

  @override
  void initState() {
    super.initState();
    _itemCubit = getIt<ItemCubit>();
    _itemCubit.getAllItems(resId: widget.restaurantId);
  }

  @override
  void close() {
    _itemCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _itemCubit,
      child: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          // If loading or error, we might hide the section or show shimmer
          // For now we check if we have items
          
          final cubit = context.read<ItemCubit>();
          // allItems in cubit might be paginated, so let's stick to _allItemsFromBackend if we want everything
          // or use the response from State.
          
          return state.maybeWhen(
             getItemSuccess: (response) {
               final allItems = response.response?.items ?? [];
               // Filter for best sellers
               final bestSellers = allItems.where((item) => item.isBestSeller == true).toList();
               
               final restaurant = response.response?.restaurant;
               final isOpen = restaurant?.isOpen ?? true;

               if (bestSellers.isEmpty) {
                 return SizedBox.shrink();
               }

               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   BestPicksTextRow(themeState: widget.themeState),
                   BestPicksBody(items: bestSellers, isOpen: isOpen, restaurant: restaurant),
                 ],
               );
             },
             getItemLoading: () => Center(child: CircularProgressIndicator(color: AppColors.primaryDeafult,)),
             orElse: () => SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
