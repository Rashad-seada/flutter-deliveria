import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      clipBehavior: Clip.none,
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
      duration: const Duration(seconds: 2),
      clipBehavior: Clip.none,
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
      duration: const Duration(seconds: 2),
      clipBehavior: Clip.none,
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

