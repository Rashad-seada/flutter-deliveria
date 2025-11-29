import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/admin/coupons/ui/widgets/drop_down_order_status_coupon.dart';
import 'package:delveria/features/admin/slider/ui/widgets/create_slider_bloc_listener.dart';
import 'package:delveria/features/admin/slider/ui/widgets/slider_upload_photo_container.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewSlider extends StatefulWidget {
  const AddNewSlider({super.key});

  @override
  State<AddNewSlider> createState() => _AddNewSliderState();
}

class _AddNewSliderState extends State<AddNewSlider> {
  List<bool> isSliderUploaded = List<bool>.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          canPop: true,
          showTitle: true,
          title: AppStrings.addnewSlider.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
          reset: false,
          delete: true,
        ),
      ),
      body: BlocConsumer<SlidersCubit, SlidersState>(
        listener: (context, state) {
          // Update isSliderUploaded based on createSuccess and deleteSuccess
          state.whenOrNull(
            createSuccess: (data, index) {
              if (index >= 0 && index < isSliderUploaded.length) {
                setState(() {
                  isSliderUploaded[index] = true;
                });
              }
            },
            deleteSuccess: (data, index) {
              if (index >= 0 && index < isSliderUploaded.length) {
                setState(() {
                  isSliderUploaded[index] = false;
                });
              }
            },
          );
        },
        builder: (context, state) {
          final cubit = context.read<SlidersCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: BlocBuilder<CouponeCubit, CouponeState>(
                builder: (context, state) {
                  final couponeCubit = context.read<CouponeCubit>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(64),
                      ...List.generate(5, (index) {
                        return Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppStrings.uploadvideos.tr()}${index + 1}",
                              style: TextStyles.bimini16W700,
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await cubit.pickPhoto(index: index);
                                    setState(
                                      () {},
                                    ); // Rebuild to show new image
                                  },
                                  child: SliderUploadPhotoContainer(
                                    cubit: cubit,
                                    index: index,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    cubit.saveSliderForIndex(
                                      index,
                                      couponeCubit.resturantId,
                                    );
                                  },
                                  child: CreateSliderBlocListener(
                                    sliderIndex: index,
                                    child: Container(
                                      width: 45.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryDeafult,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "save",
                                          style: TextStyles.bimini14W400White
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            DropDownOrderStatusCoupon(),
                            verticalSpace(32),
                          ],
                        );
                      }),
                      // Center(child: AppButton(title: AppStrings.saveSlider)),
                      verticalSpace(50),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
