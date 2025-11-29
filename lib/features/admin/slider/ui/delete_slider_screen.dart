import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/slider/ui/widgets/delete_slider_bloc_listener.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteSliderScreen extends StatelessWidget {
  const DeleteSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: "Delete Slider",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<SlidersCubit, SlidersState>(
        builder: (context, state) {
          final cubit = context.read<SlidersCubit>();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: List.generate(cubit.sliders.length, (int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        width: 150.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        imageUrl:
                            "${ApiConstants.baseUrl}/${cubit.sliders[index].image}",
                        placeholder:
                            (context, url) => Center(child: CustomLoading()),
                        errorWidget: (context, url, error) {
                          return Center(child: CustomLoading());
                        },
                      ),
                      DeleteSliderBlocListener(
                        sliderIndex: index,
                        child: GestureDetector(
                          onTap: () {
                            cubit.deleteSliderForIndex(
                              index,
                              cubit.sliders[index].id,
                            );
                          },
                          child: Image.asset(
                            AppImages.trach,
                            width: 30.w,
                            height: 30.h,
                            color: AppColors.primaryDeafult,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
