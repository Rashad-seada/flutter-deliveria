import 'package:delveria/features/client/orders/logic/cubit/order_cubit.dart';
import 'package:delveria/features/client/orders/logic/cubit/order_state.dart';
import 'package:delveria/features/client/orders/ui/widgets/animated_builder_dash_line.dart';
import 'package:delveria/features/client/orders/ui/widgets/step_container_information.dart';
import 'package:delveria/features/client/orders/ui/widgets/step_icon.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildOrderStep extends StatelessWidget {
  final int index;
  final String time;
  const BuildOrderStep({
    super.key,
    required this.index,
    required this.themeState, required this.time,
  });
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final step = state.orderSteps[index];
        final arabicStep = state.orderStepsArabic[index];
        final isLast = index == state.orderSteps.length - 1;
        final isCompleted = index < state.currentStep;
        final isCurrent = index == state.currentStep;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  StepIcon(isCompleted: isCompleted, isCurrent: isCurrent),

                  if (!isLast)
                    AnimatedBuilderForDashLine(
                      isCompleted: isCompleted,
                      isCurrent: isCurrent,
                      state: state,
                    ),
                ],
              ),
              const SizedBox(width: 16),

              StepContainerInformation(
                isCompleted: isCompleted,
                isCurrent: isCurrent,
                step: context.locale.languageCode=="ar"?arabicStep: step,
                themeState: themeState,
                time: time,
              ),
            ],
          ),
        );
      },
    );
  }
}
