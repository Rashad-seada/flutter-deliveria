import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesiredToppingsList extends StatelessWidget {
  const DesiredToppingsList({
    super.key,
    required this.state,
    required this.themeState,
    this.item,
  });
  final ResturantMenuState state;
  final ThemeState themeState;
  final ItemModel? item;

  @override
  Widget build(BuildContext context) {
    final toppings = item?.toppings ?? [];
    if (toppings.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: toppings.map((topping) {
        final isSelected = state.selectedTopping == topping.topping;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () {
              
              context.read<ResturantMenuCubit>().updateSelectedTopping(
                newSelectedTopping: topping.topping ?? '',
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected
                      ? AppColors.primaryDeafult
                      : AppColors.primaryDeafult,
                ),
                const SizedBox(width: 8),
                Text(
                  topping.topping ?? '',
                  style: TextStyles.bimini16W700.copyWith(
                    color: isSelected
                        ? AppColors.primaryDeafult
                        : themeState.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                const Spacer(),
                
                Text(
                  '${(topping.price ?? 0).toInt()} L.E',
                  style: TextStyles.bimini16W400Body.copyWith(
                    color: isSelected
                        ? AppColors.primaryDeafult
                        : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
