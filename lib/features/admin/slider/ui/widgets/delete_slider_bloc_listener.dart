import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteSliderBlocListener extends StatelessWidget {
  const DeleteSliderBlocListener({
    super.key,
    required this.child,
    this.sliderIndex,
  });

  final Widget child;
  final int? sliderIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SlidersCubit, SlidersState>(
      listenWhen: (previous, current) {
        if (sliderIndex != null) {
          if (current is DeleteSuccess && current.index == sliderIndex)
            return true;
          if (current is DeleteFail && current.index == sliderIndex)
            return true;
          return false;
        }
        if (current is DeleteSuccess) return true;
        if (current is DeleteFail) return true;
        return false;
      },
      listener: (context, state) {
        state.whenOrNull(
          deleteSuccess: (data, index) {
            if (sliderIndex == null || index == sliderIndex) {
              showSuccessSnackBar(context, "Slider deleted successfully");
            }
            context.read<SlidersCubit>().getSliders();
          },
          deleteFail: (error, index) {
            if (sliderIndex == null || index == sliderIndex) {
              showErrorSnackBar(context, error.message);
            }
          },
        );
      },
      buildWhen: (previous, current) {
        if (sliderIndex != null) {
          if (current is DeleteLoading && current.index == sliderIndex)
            return true;
          if (current is! DeleteLoading) return true;
          return false;
        }
        if (current is DeleteLoading) return true;
        if (current is! DeleteLoading) return true;
        return false;
      },
      builder: (context, state) {
        // Show loading only for this sliderIndex (if provided)
        if (sliderIndex != null) {
          if (state is DeleteLoading && state.index == sliderIndex) {
            return CustomLoading();
          }
          if (state.maybeWhen(
            deleteLoading: (index) => index == sliderIndex,
            orElse: () => false,
          )) {
            return CustomLoading();
          }
        } else {
          if (state is DeleteLoading) {
            return CustomLoading();
          }
          if (state.maybeWhen(
            deleteLoading: (index) => true,
            orElse: () => false,
          )) {
            return CustomLoading();
          }
        }
        return child;
      },
    );
  }
}
