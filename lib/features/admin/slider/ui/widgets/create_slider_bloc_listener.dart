import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSliderBlocListener extends StatelessWidget {
  const CreateSliderBlocListener({
    super.key,
    required this.child,
    required this.sliderIndex,
  });

  final Widget child;
  final int sliderIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SlidersCubit, SlidersState>(
      listenWhen: (previous, current) {
        // Only listen if the event is for this sliderIndex
        if (current is CreateSuccess && current.index == sliderIndex)
          return true;
        if (current is CreateFail && current.index == sliderIndex) return true;
        return false;
      },
      listener: (context, state) {
        state.whenOrNull(
          createSuccess: (data, index) {
            if (index == sliderIndex) {
              showSuccessSnackBar(context, "Slider created successfully");
            }
            context.read<SlidersCubit>().getSliders();
          },
          createFail: (error, index) {
            if (index == sliderIndex) {
              showErrorSnackBar(context, error.message);
            }
          },
        );
      },
      buildWhen: (previous, current) {
        // Only rebuild if loading state is for this sliderIndex
        if (current is CreateLoading && current.index == sliderIndex)
          return true;
        if (current is! CreateLoading) return true;
        return false;
      },
      builder: (context, state) {
        // Show loading only for this sliderIndex
        if (state is CreateLoading && state.index == sliderIndex) {
          return CustomLoading();
        }
        if (state.maybeWhen(
          createLoading: (index) => index == sliderIndex,
          orElse: () => false,
        )) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
