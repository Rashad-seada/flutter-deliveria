import 'package:delveria/features/client/onboarding/ui/widgets/on_boarding_bloc.dart';
import 'package:delveria/features/client/onboarding/ui/widgets/skip_button.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [OnBoardingBloc()]),
                ),
                SkipButton(theme: state),
              ],
            ),
          ),
        );
      },
    );
  }
}
