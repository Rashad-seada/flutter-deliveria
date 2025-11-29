import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_cubit.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_state.dart';
import 'package:delveria/features/client/reviews/ui/widgets/add_review_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReviewScreen extends StatefulWidget {
  AddReviewScreen({super.key, required this.resId});
  final String resId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController reviewsController = TextEditingController();
  int selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
            onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
          title: "Add Review",
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(52),
            Text("Review Content", style: TextStyles.bimini20W700),
            verticalSpace(32),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < selectedStars
                        ? Icons.star
                        : Icons.star_border_outlined,
                    color: index < selectedStars
                        ? Colors.amber
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedStars = index + 1;
                    });
                  },
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                );
              }),
            ),
            CustomFormW(
              showButton: false,
              padding: EdgeInsetsGeometry.zero,
              children: [
                CustomTextField(
                  controller: reviewsController,
                  hint: "Write your reviews and comments here.",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyles.bimini13W400Grey,
                  maxLines: 5,
                ),
              ],
            ),
            verticalSpace(65),
            AddReviewBlocListener(
              child: BlocBuilder<ReviewsCubit, ReviewsState>(
                builder: (context, state) {
                  final cubit = context.read<ReviewsCubit>();
                  return Center(
                    child: AppButton(
                      title: "Add your review",
                      onPressed: () {
                        cubit.addReview(
                          body: {
                            "restaurant_id": widget.resId,
                            "rate_number": selectedStars,
                            "message": reviewsController.text,
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
