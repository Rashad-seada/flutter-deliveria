import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildDot({required int index}) {
  return BlocBuilder<OnboradingCubit, OnboradingState>(
    builder: (context, state) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 5),
        height: 8,
        width: state.currentPage == index ? 24 : 8,
        decoration: BoxDecoration(
          color:
              state.currentPage == index
                  ? AppColors.primaryDeafult
                  : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      );
    },
  );
}
