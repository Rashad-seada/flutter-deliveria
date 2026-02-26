import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/ResturantOwner/branches/data/models/branch_model.dart';
import 'package:delveria/features/ResturantOwner/branches/logic/cubit/branches_cubit.dart';
import 'package:delveria/features/ResturantOwner/branches/logic/cubit/branches_state.dart';
import 'package:delveria/features/client/adresses/ui/location_picker_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEditBranchScreen extends StatefulWidget {
  final String restaurantId;
  final BranchModel? branch; // null = create new, non-null = edit

  const AddEditBranchScreen({
    super.key,
    required this.restaurantId,
    this.branch,
  });

  @override
  State<AddEditBranchScreen> createState() => _AddEditBranchScreenState();
}

class _AddEditBranchScreenState extends State<AddEditBranchScreen> {
  final _formKey = GlobalKey<FormState>(); // Added form key
  late final TextEditingController _branchNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _openHourController;
  late final TextEditingController _closeHourController;
  late final TextEditingController _deliveryCostController;
  late final TextEditingController _preparationTimeController;
  late final TextEditingController _deliveryTimeController;

  LatLng? _selectedLocation;
  bool get isEditing => widget.branch != null;

  @override
  void initState() {
    super.initState();
    final branch = widget.branch;
    _branchNameController = TextEditingController(text: branch?.branchName ?? '');
    _phoneController = TextEditingController(text: branch?.phone ?? '');
    _addressController = TextEditingController(text: branch?.locationMap ?? '');
    _openHourController = TextEditingController(text: branch?.openHour ?? '');
    _closeHourController = TextEditingController(text: branch?.closeHour ?? '');
    _deliveryCostController = TextEditingController(text: branch?.deliveryCost?.toString() ?? '');
    _preparationTimeController = TextEditingController(text: branch?.preparationTime?.toString() ?? '');
    _deliveryTimeController = TextEditingController(text: branch?.deliveryTime?.toString() ?? '');

    if (branch?.coordinates?.latitude != null && branch?.coordinates?.longitude != null) {
      final lat = (branch!.coordinates!.latitude as num).toDouble();
      final lng = (branch.coordinates!.longitude as num).toDouble();
      _selectedLocation = LatLng(lat, lng);
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPickerScreen(),
      ),
    );

    if (result != null && result is Map) {
      setState(() {
        if (result['location'] is LatLng) {
          _selectedLocation = result['location'];
        }
        if (result['address'] is String) {
          _addressController.text = result['address'];
        }
      });
    }
  }

  @override
  void dispose() {
    _branchNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _openHourController.dispose();
    _closeHourController.dispose();
    _deliveryCostController.dispose();
    _preparationTimeController.dispose();
    _deliveryTimeController.dispose();
    super.dispose();
  }

  Future<void> _saveBranch() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Manual check generally not needed for required fields validated by Form, 
    // but address might be auto-filled so keeping controller text check is implicit by validator.

    final data = {
      'branch_name': _branchNameController.text,
      'phone': _phoneController.text,
      'location_map': _addressController.text,
      'open_hour': _openHourController.text,
      'close_hour': _closeHourController.text,
      'delivery_cost': num.tryParse(_deliveryCostController.text) ?? 0,
      'preparation_time': int.tryParse(_preparationTimeController.text) ?? 15,
      'delivery_time': int.tryParse(_deliveryTimeController.text) ?? 30,
    };

    if (_selectedLocation != null) {
      data['latitude'] = _selectedLocation!.latitude;
      data['longitude'] = _selectedLocation!.longitude;
    } else if (isEditing && (widget.branch?.coordinates?.latitude != null)) {
         // Keep existing coordinates
    } else {
        // Warning if needed, but for now we proceed
    }

    final cubit = context.read<BranchesCubit>();

    if (isEditing) {
      await cubit.updateBranch(widget.branch!.id!, data);
    } else {
      await cubit.createBranch(widget.restaurantId, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BranchesCubit, BranchesState>(
      listener: (context, state) {
        state.maybeWhen(
          createBranchSuccess: (_) {
            showSuccessSnackBar(context, AppStrings.branchCreatedSuccess.tr());
            Navigator.pop(context);
          },
          createBranchError: (error) {
            showErrorSnackBar(context, error);
          },
          updateBranchSuccess: (_) {
            showSuccessSnackBar(context, AppStrings.branchUpdatedSuccess.tr());
            Navigator.pop(context);
          },
          updateBranchError: (error) {
            showErrorSnackBar(context, error);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
         final isLoading = state.maybeWhen(
            createBranchLoading: () => true,
            updateBranchLoading: () => true,
            orElse: () => false,
          );

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: ArrowBackAppBarWithTitle(
              showTitle: true,
              title: isEditing ? AppStrings.editBranch.tr() : AppStrings.addNewBranch.tr(),
              titleStyle: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult),
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Branch Name
                        _buildTextField(
                          label: "${AppStrings.branchName.tr()} *",
                          controller: _branchNameController,
                          hint: "e.g., Downtown Branch",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppStrings.branchNameRequired.tr();
                            }
                            return null;
                          },
                        ),
                        verticalSpace(16),

                        // Phone
                        _buildTextField(
                          label: "${AppStrings.mobileNumber.tr()} *",
                          controller: _phoneController,
                          hint: "+20 123 456 789",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppStrings.phoneRequired.tr();
                            }
                            return null;
                          },
                        ),
                        verticalSpace(16),

                        // Address
                        _buildTextField(
                          label: "${AppStrings.address.tr()} *",
                          controller: _addressController,
                          hint: AppStrings.address.tr(),
                          maxLines: 2,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.map, color: AppColors.primaryDeafult),
                            onPressed: _pickLocation,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppStrings.addressRequired.tr();
                            }
                            return null;
                          },
                        ),
                        if (_selectedLocation != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              "${AppStrings.locationSelected.tr()}: ${_selectedLocation!.latitude.toStringAsFixed(6)}, ${_selectedLocation!.longitude.toStringAsFixed(6)}",
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                            ),
                          ),
                        verticalSpace(24),

                        // Hours Section
                        Text(AppStrings.openingHours.tr(), style: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult)),
                        verticalSpace(12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: AppStrings.openHour.tr(),
                                controller: _openHourController,
                                hint: "09:00",
                                keyboardType: TextInputType.datetime, 
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: _buildTextField(
                                label: AppStrings.closeHour.tr(),
                                controller: _closeHourController,
                                hint: "22:00",
                                 keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(24),

                        // Delivery Section
                        Text(AppStrings.delivery.tr(), style: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult)),
                        verticalSpace(12),
                        _buildTextField(
                          label: AppStrings.deliveryCost.tr(),
                          controller: _deliveryCostController,
                          hint: "15",
                          keyboardType: TextInputType.number,
                          suffix: AppStrings.le.tr(),
                        ),
                        verticalSpace(16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: AppStrings.prepTime.tr(),
                                controller: _preparationTimeController,
                                hint: "20",
                                keyboardType: TextInputType.number,
                                suffix: AppStrings.min.tr(),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: _buildTextField(
                                label: AppStrings.deliveryTime.tr(),
                                controller: _deliveryTimeController,
                                hint: "35",
                                keyboardType: TextInputType.number,
                                suffix: AppStrings.min.tr(),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(32),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            title: isEditing ? AppStrings.saveChanges.tr() : AppStrings.createBranch.tr(),
                            onPressed: _saveBranch,
                          ),
                        ),
                        verticalSpace(24),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? suffix,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.bimini14W700.copyWith(color: Colors.black87)),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            suffixText: suffix,
            suffixIcon: suffixIcon,
            suffixStyle: TextStyles.bimini14W700.copyWith(color: AppColors.primaryDeafult),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.primaryDeafult, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }
}
