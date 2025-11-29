import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_cubit.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReviewBlocListener extends StatelessWidget {
  const AddReviewBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listenWhen: (previous, current) => current is Success || current is Fail,
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            showSuccessSnackBar(context, "Review Added successfully ");
            context.pop();
          },
          fail: (error) {
            showErrorSnackBar(context, error.message);
          },
        );
      },
      buildWhen:
          (previous, current) => current is Loading || current is! Loading,
      builder: (context, state) {
        if (state is Loading ||
            state.maybeWhen(loading: () => true, orElse: () => false)) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
