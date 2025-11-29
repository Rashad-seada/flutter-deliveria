import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/client/orders/logic/cubit/order_cubit.dart';
import 'package:delveria/features/client/orders/ui/widgets/build_order_step.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:delveria/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveredOnBody extends StatefulWidget {
  const DeliveredOnBody({
    super.key,
    required this.time,
    required this.initialStatus,
  });
  final String time;
  final String initialStatus;

  @override
  State<DeliveredOnBody> createState() => _DeliveredOnBodyState();
}

class _DeliveredOnBodyState extends State<DeliveredOnBody> {
  bool _dialogShown = false;

  
  // bool _isOrderCanceled(dynamic state) {
  //   if (state != null &&
  //       state.orderSteps != null &&
  //       state.orderSteps.isNotEmpty &&
  //       widget.initialStatus == "Canceled") {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      AppStrings.deliverOn.tr(),
                      style: TextStyles.bimini20W400,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 20.sp,
                          color: AppColors.primaryDeafult,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.halfHour.tr(),
                          style: TextStyles.bimini14W400White.copyWith(
                            color:
                                themeState.themeMode == ThemeMode.dark
                                    ? AppColors.lightGrey
                                    : AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<OrderCubit, dynamic>(
                  builder: (context, state) {
                    // // Show cancel dialog if state is cancel
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (_isOrderCanceled(state)) {
                    //     _showCanceledDialog(context);
                    //   }
                    // });
                    return ListView.builder(
                      itemCount: state.orderSteps.length,
                      itemBuilder: (context, index) {
                        return BuildOrderStep(
                          index: index,
                          themeState: themeState,
                          time: widget.time,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
