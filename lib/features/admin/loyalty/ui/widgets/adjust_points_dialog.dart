import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/loyalty/data/models/admin_loyalty_models.dart';
import 'package:delveria/features/admin/loyalty/logic/cubit/admin_loyalty_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdjustPointsDialog extends StatefulWidget {
  final UserPointsSummary user;

  const AdjustPointsDialog({super.key, required this.user});

  @override
  State<AdjustPointsDialog> createState() => _AdjustPointsDialogState();
}

class _AdjustPointsDialogState extends State<AdjustPointsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _pointsController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isAdding = true;

  @override
  void dispose() {
    _pointsController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.adjustPoints.tr(),
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              verticalSpace(8),
              Text(
                "${AppStrings.user.tr()}: ${widget.user.fullName}",
                style: TextStyles.bimini14W500.copyWith(color: Colors.grey),
              ),
              Text(
                "${AppStrings.currentPoints.tr()}: ${widget.user.totalPoints ?? 0}",
                style: TextStyles.bimini14W500.copyWith(color: Colors.grey),
              ),
              verticalSpace(24),

              // Add/Remove toggle
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isAdding = true),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: _isAdding
                              ? Colors.green.withOpacity(0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: _isAdding ? Colors.green : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: _isAdding ? Colors.green : Colors.grey,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.add.tr(),
                              style: TextStyles.bimini14W600.copyWith(
                                color: _isAdding ? Colors.green : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isAdding = false),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: !_isAdding
                              ? Colors.red.withOpacity(0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: !_isAdding ? Colors.red : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove,
                              color: !_isAdding ? Colors.red : Colors.grey,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.remove.tr(),
                              style: TextStyles.bimini14W600.copyWith(
                                color: !_isAdding ? Colors.red : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(16),

              // Points amount
              TextFormField(
                controller: _pointsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppStrings.pointsAmount.tr(),
                  hintText: "100",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterPointsAmount.tr();
                  }
                  final points = int.tryParse(value);
                  if (points == null || points <= 0) {
                    return AppStrings.pleaseEnterValidPositiveNumber.tr();
                  }
                  return null;
                },
              ),
              verticalSpace(16),

              // Reason
              TextFormField(
                controller: _reasonController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppStrings.reasonOptional.tr(),
                  hintText: AppStrings.reasonHint.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              verticalSpace(24),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppStrings.cancel.tr()),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isAdding ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(_isAdding ? AppStrings.addPoints.tr() : AppStrings.removePoints.tr()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final points = int.parse(_pointsController.text);
    final adjustedPoints = _isAdding ? points : -points;

    final success = await context.read<AdminLoyaltyCubit>().adjustUserPoints(
          userId: widget.user.id!,
          points: adjustedPoints,
          reason: _reasonController.text.isNotEmpty ? _reasonController.text : null,
        );

    if (success && mounted) {
      Navigator.pop(context);
    }
  }
}
