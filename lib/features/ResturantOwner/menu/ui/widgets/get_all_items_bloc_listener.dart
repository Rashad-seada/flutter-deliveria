import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GetAllItemsBlocListener extends StatelessWidget {
  const GetAllItemsBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listenWhen:
          (previous, current) =>
              current is GetItemSuccess || current is GetItemFail,
      listener: (context, state) {
        state.whenOrNull(
          getItemFail: (error) {
            return Center(child: Text(error.message));
          },
        );
      },
      buildWhen:
          (previous, current) =>
              current is GetItemLoading || current is! GetItemLoading,
      builder: (context, state) {
        if (state is GetItemLoading ||
            state.maybeWhen(getItemLoading: () => true, orElse: () => false)) {
          return Center(
            child: LoadingAnimationWidget.newtonCradle(
              color: AppColors.primaryDeafult,
              size: 120,
            ),
          );
        }
        return child;
      },
    );
  }
}
