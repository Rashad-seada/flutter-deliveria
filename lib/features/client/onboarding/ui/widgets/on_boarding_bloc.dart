import 'package:carousel_slider/carousel_slider.dart';
import 'package:delveria/core/helper/lists.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_state.dart';
import 'package:delveria/features/client/onboarding/ui/widgets/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingBloc extends StatelessWidget {
  const OnBoardingBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboradingCubit, OnboradingState>(
      builder: (context, state) {
        final cubit = context.read<OnboradingCubit>();
        return CarouselSlider.builder(
          carouselController: cubit.carouselController,
          itemCount: AppLists.onboardingData.length,
          itemBuilder: (context, index, realIdx) {
            return OnboardingPage(
              index: index,
              title: AppLists.onboardingData[index]["title"]!,
              description: AppLists.onboardingData[index]["description"]!,
              image: AppLists.onboardingData[index]["image"]!,
              currentPage: state.currentPage,
            );
          },
          options: CarouselOptions(
            height: 690.h,
            viewportFraction: .7,
            enableInfiniteScroll: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              context.read<OnboradingCubit>().updateCurrentPage(index);
            },
            initialPage: state.currentPage,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        );
      },
    );
  }
}
