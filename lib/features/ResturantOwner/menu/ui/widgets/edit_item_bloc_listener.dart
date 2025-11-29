import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditItemBlocListener extends StatelessWidget {
  const EditItemBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listenWhen:
          (previous, current) => current is EditSuccess || current is EditFail,
      listener: (context, state) async {
        state.whenOrNull(
          editSuccess: (data) async {
            showSuccessSnackBar(context, "Item Edited Successfully ");
            context.pop();
          },
          editFail: (error) {
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) =>
              current is EditLoading || current is! EditLoading,
      builder: (context, state) {
        if (state is EditLoading ||
            state.maybeWhen(editLoading: () => true, orElse: () => false)) {
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
