import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateItemBlocListener extends StatelessWidget {
  const CreateItemBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemCubit, ItemState>(
      listenWhen: (previous, current) =>
          current is ItemStateSuccess || current is ItemStateFail,
      listener: (context, state) async {
        state.whenOrNull(
          success: (data) async {
            showSuccessSnackBar(context, "Item Created Successfully ");
            // Await the result to ensure we get the String, not a Future
            final resId = await SharedPrefHelper.getString(SharedPrefKeys.resId);
            context.pushNamed(Routes.resturantBottomBar, arguments: resId);
          },
          fail: (error) {
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen: (previous, current) =>
          current is ItemStateLoading || current is! ItemStateLoading,
      builder: (context, state) {
        if (state is ItemStateLoading ||
            state.maybeWhen(loading: () => true, orElse: () => false)) {
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
