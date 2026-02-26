import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable delete confirmation dialog
class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String itemName;
  final VoidCallback onConfirm;
  final bool isLoading;

  const DeleteConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.itemName,
    required this.onConfirm,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title,
              style: TextStyles.bimini18W700.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyles.bimini14W700.copyWith(color: Colors.black87),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.red.shade700, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    itemName,
                    style: TextStyles.bimini14W700.copyWith(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context, false),
          child: Text(
            "Cancel",
            style: TextStyles.bimini14W700.copyWith(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : () {
            onConfirm();
            Navigator.pop(context, true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  "Delete",
                  style: TextStyles.bimini14W700.copyWith(color: Colors.white),
                ),
        ),
      ],
    );
  }

  /// Show the delete confirmation dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required String itemName,
    required VoidCallback onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: title,
        message: message,
        itemName: itemName,
        onConfirm: onConfirm,
      ),
    );
  }
}
