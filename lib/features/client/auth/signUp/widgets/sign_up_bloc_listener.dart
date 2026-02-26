import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      child: child,
      listenWhen:
          (previous, current) =>
              current is Loading || current is Success || current is Fail,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            Center(child: CustomLoading());
          },
          success: (data) {
            showSuccessSnackBar(context, "Account created successfully");
            context.pushNamedAndRemoveUntil(
              Routes.loginScreen,
              predicate: (Route<dynamic> route) => false,
            );
          },
          fail: (apiErrorModel) {
            final cubit = context.read<SignupCubit>();
            final errorCode = apiErrorModel.errorCode;

            // Clear previous field errors before setting new ones
            cubit.clearFieldErrors();

            switch (errorCode) {
              // ── Missing fields ─────────────────────────────────
              case 'MISSING_FIELDS':
                final missing = apiErrorModel.missingFields ?? [];
                for (final f in missing) {
                  cubit.setFieldError(f, 'This field is required');
                }
                showWarningSnackBar(context, apiErrorModel.message);
                break;

              // ── Inline validation errors ───────────────────────
              case 'INVALID_FIRST_NAME':
              case 'INVALID_LAST_NAME':
              case 'INVALID_PHONE_FORMAT':
              case 'WEAK_PASSWORD':
                final field = apiErrorModel.field;
                if (field != null) {
                  cubit.setFieldError(field, apiErrorModel.message);
                }
                showErrorSnackBar(context, apiErrorModel.message);
                break;

              // ── Phone already registered → Go to Login dialog ──
              case 'PHONE_ALREADY_REGISTERED':
                _showGoToLoginDialog(context, apiErrorModel.message);
                break;

              // ── Phone used by another role ─────────────────────
              case 'PHONE_USED_BY_OTHER_ROLE':
                cubit.setFieldError('phone', apiErrorModel.message);
                showErrorSnackBar(context, apiErrorModel.message);
                break;

              // ── Server error ───────────────────────────────────
              case 'SERVER_ERROR':
                showErrorSnackBar(
                  context,
                  'An unexpected error occurred. Please try again later.',
                );
                break;

              // ── Fallback (no error_code or unknown) ────────────
              default:
                showErrorSnackBar(context, apiErrorModel.message);
                break;
            }

            // Trigger a rebuild so the field widgets pick up the new errors
            cubit.emit(SignupState.initial());
          },
        );
      },
    );
  }

  void _showGoToLoginDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.primary),
            SizedBox(width: 8),
            Text('Account Exists',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Text(message, style: TextStyle(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.pushNamedAndRemoveUntil(
                Routes.loginScreen,
                predicate: (route) => false,
              );
            },
            child: Text('Go to Login', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
