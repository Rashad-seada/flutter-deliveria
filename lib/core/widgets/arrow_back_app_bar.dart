import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowBackAppBarWithTitle extends StatelessWidget {
  const ArrowBackAppBarWithTitle({
    super.key,
    required this.showTitle,
    this.title,
    this.titleStyle,
    this.bgcolor,
    this.sucolor,
    this.reset,
    this.update,
    this.delete,
    this.canPop = true,
    this.onUpdateTap,
    this.onBack,
    this.showRefresh, this.widget, this.dontShowArrow,
  });
  final bool showTitle;
  final String? title;
  final TextStyle? titleStyle;
  final Color? bgcolor, sucolor;
  final bool? reset;
  final bool? update;
  final bool? delete;
  final bool? showRefresh;
  final bool? dontShowArrow;
  final Widget? widget;
  final bool? canPop;
  final void Function()? onUpdateTap;
  final void Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AppBar(
          backgroundColor:
              state.themeMode == ThemeMode.dark
                  ? Colors.black12
                  : bgcolor ?? Colors.white,
          surfaceTintColor:
              state.themeMode == ThemeMode.dark
                  ? Colors.black
                  : sucolor ?? Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading:dontShowArrow==true?SizedBox(): GestureDetector(
            onTap:
                onBack ??
                () {
                  if (canPop == true) {
                    context.pop();
                  } else {
                    SystemNavigator.pop();
                  }
                },
            child: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title:
              showTitle
                  ? Text(
                    title ?? "",
                    style: titleStyle?.copyWith(
                      color:
                          state.themeMode == ThemeMode.dark
                              ? Colors.white
                              : null,
                    ),
                  )
                  : null,
          actions: [
            showRefresh == true ? widget! : SizedBox(),
            reset == true || update == true
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: update == true ? onUpdateTap : () {},
                    child: Text(
                      update == true ? "update".tr() : "reset".tr(),
                      style: TextStyles.bimini16W400Body.copyWith(
                        color: AppColors.primaryDeafult,
                        height: 3,
                        decoration: TextDecoration.underline,

                        decorationColor: AppColors.primaryDeafult,
                        decorationThickness: 5,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                )
                : delete == true
                ? GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.deleteSliderScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      AppImages.trach,
                      width: 30.w,
                      height: 30.h,
                      color: AppColors.primaryDeafult,
                    ),
                  ),
                )
                : SizedBox(),
          ],
          centerTitle: showTitle,
        );
      },
    );
  }
}
