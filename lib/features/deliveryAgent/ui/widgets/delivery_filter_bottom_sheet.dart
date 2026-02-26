import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterData {
  String? date;
  String? startDate;
  String? endDate;
  String? paymentType;
  String? orderType;
  String? status;

  FilterData({
    this.date,
    this.startDate,
    this.endDate,
    this.paymentType,
    this.orderType,
    this.status,
  });

  bool get isEmpty =>
      date == null &&
      startDate == null &&
      endDate == null &&
      paymentType == null &&
      orderType == null &&
      status == null;
}

class DeliveryFilterBottomSheet extends StatefulWidget {
  final bool isAvailableOrdersTab;
  final FilterData? initialFilters;
  final Function(FilterData) onApply;

  const DeliveryFilterBottomSheet({
    super.key,
    required this.isAvailableOrdersTab,
    this.initialFilters,
    required this.onApply,
  });

  @override
  State<DeliveryFilterBottomSheet> createState() =>
      _DeliveryFilterBottomSheetState();
}

class _DeliveryFilterBottomSheetState extends State<DeliveryFilterBottomSheet> {
  DateTime? _selectedDate;
  String? _selectedPaymentType;
  String? _selectedOrderType;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.initialFilters != null) {
      if (widget.initialFilters!.date != null) {
        _selectedDate = DateTime.tryParse(widget.initialFilters!.date!);
      }
      _selectedPaymentType = widget.initialFilters!.paymentType;
      _selectedOrderType = widget.initialFilters!.orderType;
      _selectedStatus = widget.initialFilters!.status;
    }
  }

  void _reset() {
    setState(() {
      _selectedDate = null;
      _selectedPaymentType = null;
      _selectedOrderType = null;
      _selectedStatus = null;
    });
  }

  void _apply() {
    widget.onApply(
      FilterData(
        date: _selectedDate?.toIso8601String().split('T')[0],
        paymentType: _selectedPaymentType,
        orderType: _selectedOrderType,
        status: _selectedStatus,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filter Orders", style: TextStyles.bimini16W700),
              TextButton(
                onPressed: _reset,
                child: Text(
                  "Reset",
                  style: TextStyles.bimini14W500.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
          verticalSpace(16),
          _buildSectionTitle("Date"),
          verticalSpace(8),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 20.sp, color: Colors.grey),
                  horizontalSpace(8),
                  Text(
                    _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : "Select Date",
                    style: TextStyles.bimini14W500.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          verticalSpace(16),
          _buildSectionTitle("Payment Type"),
          verticalSpace(8),
          Row(
            children: [
              _buildChip("Cash", "Cash"),
              horizontalSpace(8),
              _buildChip("Visa", "Visa"),
            ],
          ),
          if (widget.isAvailableOrdersTab) ...[
            verticalSpace(16),
            _buildSectionTitle("Order Type"),
            verticalSpace(8),
            Row(
              children: [
                _buildOrderTypeChip("Single", "Single"),
                horizontalSpace(8),
                _buildOrderTypeChip("Multi", "Multi"),
              ],
            ),
          ],
          if (!widget.isAvailableOrdersTab) ...[
            verticalSpace(16),
            _buildSectionTitle("Status"),
            verticalSpace(8),
            Row(
              children: [
                _buildStatusChip("Active", "active"),
                horizontalSpace(8),
                _buildStatusChip("History", "history"),
              ],
            ),
          ],
          verticalSpace(24),
          AppButton(title: "Apply Filter", onPressed: _apply),
          verticalSpace(10),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyles.bimini14W500.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildChip(String label, String value) {
    final isSelected = _selectedPaymentType == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedPaymentType = selected ? value : null;
        });
      },
      selectedColor: AppColors.primaryDeafult.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryDeafult : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primaryDeafult : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildOrderTypeChip(String label, String value) {
    final isSelected = _selectedOrderType == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedOrderType = selected ? value : null;
        });
      },
      selectedColor: AppColors.primaryDeafult.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryDeafult : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primaryDeafult : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, String value) {
    final isSelected = _selectedStatus == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = selected ? value : null;
        });
      },
      selectedColor: AppColors.primaryDeafult.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryDeafult : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primaryDeafult : Colors.transparent,
        ),
      ),
    );
  }
}
