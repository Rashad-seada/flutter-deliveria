import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double _snackBarBottomPadding(BuildContext context) {
  final height = 1.sh; 
  return height - 0.35 * height;
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),
      padding: EdgeInsets.only(
        bottom: _snackBarBottomPadding(context),
        top: 20.h,
      ),
      content: AwesomeSnackbarContent(
        title: 'Error!',
        titleTextStyle: TextStyles.bimini18W700,
        messageTextStyle: TextStyles.bimini14W700.copyWith(color: Colors.white),
        message: message,
        contentType: ContentType.failure,
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),

      padding: EdgeInsets.only(
        bottom: _snackBarBottomPadding(context),
        top: 20.h,
      ),
      content: AwesomeSnackbarContent(
        title: 'Success!',
        titleTextStyle: TextStyles.bimini18W700,
        messageTextStyle: TextStyles.bimini14W700.copyWith(color: Colors.white),
        message: message,
        contentType: ContentType.success,
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showWarningSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),

      padding: EdgeInsets.only(
        bottom: _snackBarBottomPadding(context),
        top: 20.h,
      ),
      content: AwesomeSnackbarContent(
        title: ' Attention !',
        titleTextStyle: TextStyles.bimini18W700,
        messageTextStyle: TextStyles.bimini14W700.copyWith(color: Colors.white),
        message: message,
        contentType: ContentType.warning,
      ),
    ),
  );
}
