import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class GuestLoginDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onLoginPressed;

  const GuestLoginDialog({
    super.key,
    this.title,
    this.message,
    this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryDeafult.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.primaryDeafult,
                size: 32,
              ),
            ),
            verticalSpace(16),
            Text(
              title ?? "Account Required",
              style: TextStyles.bimini18W700,
              textAlign: TextAlign.center,
            ),
            verticalSpace(8),
            Text(
              message ?? "Please login to access this feature and enjoy the full experience.",
              style: TextStyles.bimini14W700.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            AppButton(
              title: "Login / Register",
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                if (onLoginPressed != null) {
                  onLoginPressed!();
                } else {
                  // Default navigation to login
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    (route) => false, // Clear stack
                  );
                }
              },
            ),
            verticalSpace(12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyles.bimini14W700.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show the dialog
void showGuestLoginDialog(BuildContext context, {String? title, String? message}) {
  showDialog(
    context: context,
    builder: (context) => GuestLoginDialog(
      title: title,
      message: message,
    ),
  );
}
