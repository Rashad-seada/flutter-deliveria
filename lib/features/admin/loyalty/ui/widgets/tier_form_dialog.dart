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

class TierFormDialog extends StatefulWidget {
  final AdminRewardTier? tier;

  const TierFormDialog({super.key, this.tier});

  @override
  State<TierFormDialog> createState() => _TierFormDialogState();
}

class _TierFormDialogState extends State<TierFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _pointsController;
  late TextEditingController _discountController;
  late TextEditingController _maxDiscountController;
  late TextEditingController _descriptionController;
  
  String _discountType = 'percentage';

  bool get isEditing => widget.tier != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tier?.name ?? '');
    _pointsController = TextEditingController(
      text: widget.tier?.pointsRequired?.toString() ?? '',
    );
    _discountController = TextEditingController(
      text: widget.tier?.discountValue?.toString() ?? '',
    );
    _maxDiscountController = TextEditingController(
      text: widget.tier?.maxDiscount?.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.tier?.description ?? '',
    );
    _discountType = widget.tier?.discountType ?? 'percentage';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pointsController.dispose();
    _discountController.dispose();
    _maxDiscountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? AppStrings.editTier.tr() : AppStrings.createNewTier.tr(),
                style: TextStyles.bimini20W700.copyWith(
                  color: AppColors.primaryDeafult,
                ),
              ),
              verticalSpace(24),
              
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppStrings.tierName.tr(),
                  hintText: AppStrings.tierNameHint.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterTierName.tr();
                  }
                  return null;
                },
              ),
              verticalSpace(16),

              // Points required field
              TextFormField(
                controller: _pointsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppStrings.pointsRequired.tr(),
                  hintText: "500",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterPointsRequired.tr();
                  }
                  if (int.tryParse(value) == null) {
                    return AppStrings.pleaseEnterValidNumber.tr();
                  }
                  return null;
                },
              ),
              verticalSpace(16),

              // Discount type dropdown
              DropdownButtonFormField<String>(
                value: _discountType,
                decoration: InputDecoration(
                  labelText: AppStrings.discountType.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: 'percentage', child: Text(AppStrings.percentage.tr())),
                  DropdownMenuItem(value: 'fixed', child: Text(AppStrings.fixedAmountEgp.tr())),
                ],
                onChanged: (value) {
                  setState(() {
                    _discountType = value ?? 'percentage';
                  });
                },
              ),
              verticalSpace(16),

              // Discount value field
              TextFormField(
                controller: _discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _discountType == 'percentage'
                      ? AppStrings.discountPercentage.tr()
                      : AppStrings.discountAmountEgp.tr(),
                  hintText: _discountType == 'percentage' ? "10" : "50",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterDiscountValue.tr();
                  }
                  if (num.tryParse(value) == null) {
                    return AppStrings.pleaseEnterValidNumber.tr();
                  }
                  return null;
                },
              ),
              verticalSpace(16),

              // Max discount (for percentage only)
              if (_discountType == 'percentage')
                TextFormField(
                  controller: _maxDiscountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppStrings.maxDiscountCap.tr(),
                    hintText: "100 EGP",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              if (_discountType == 'percentage') verticalSpace(16),

              // Description field
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppStrings.descriptionOptional.tr(),
                  hintText: AppStrings.descriptionHint.tr(),
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
                      backgroundColor: AppColors.primaryDeafult,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(isEditing ? AppStrings.update.tr() : AppStrings.create.tr()),
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

    final cubit = context.read<AdminLoyaltyCubit>();
    bool success;

    if (isEditing) {
      success = await cubit.updateTier(
        widget.tier!.id!,
        name: _nameController.text,
        pointsRequired: int.parse(_pointsController.text),
        discountValue: num.parse(_discountController.text),
        discountType: _discountType,
        maxDiscount: _maxDiscountController.text.isNotEmpty
            ? num.parse(_maxDiscountController.text)
            : null,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
      );
    } else {
      success = await cubit.createTier(
        name: _nameController.text,
        pointsRequired: int.parse(_pointsController.text),
        discountValue: num.parse(_discountController.text),
        discountType: _discountType,
        maxDiscount: _maxDiscountController.text.isNotEmpty
            ? num.parse(_maxDiscountController.text)
            : null,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
      );
    }

    if (success && mounted) {
      Navigator.pop(context);
    }
  }
}
