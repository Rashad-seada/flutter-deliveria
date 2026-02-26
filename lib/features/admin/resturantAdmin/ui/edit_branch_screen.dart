import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/branch_model.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/branches_cubit.dart';
import 'package:delveria/features/client/adresses/ui/location_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditBranchScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final BranchModel? branch; // null = create new, non-null = edit

  const EditBranchScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
    this.branch,
  });

  @override
  State<EditBranchScreen> createState() => _EditBranchScreenState();
}

class _EditBranchScreenState extends State<EditBranchScreen> {
  late final TextEditingController _branchNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _openHourController;
  late final TextEditingController _closeHourController;
  late final TextEditingController _deliveryCostController;
  late final TextEditingController _preparationTimeController;
  late final TextEditingController _deliveryTimeController;
  
  LatLng? _selectedLocation;
  bool _isLoading = false;
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
    } else if (branch?.latitude != null && branch?.longitude != null) {
      _selectedLocation = LatLng(branch!.latitude!, branch.longitude!);
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
    if (_branchNameController.text.isEmpty) {
      showErrorSnackBar(context, "Branch name is required");
      return;
    }
    if (_phoneController.text.isEmpty) {
      showErrorSnackBar(context, "Phone number is required");
      return;
    }

    setState(() => _isLoading = true);

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
    }

    final cubit = context.read<BranchesCubit>();

    if (isEditing) {
      await cubit.updateBranch(widget.branch!.id!, widget.restaurantId, data);
    } else {
      await cubit.createBranch(widget.restaurantId, data);
    }

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: isEditing ? "Edit Branch" : "Add New Branch",
          titleStyle: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Parent Restaurant Info
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeafult.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.restaurant, color: AppColors.primaryDeafult),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "Parent: ${widget.restaurantName}",
                            style: TextStyles.bimini14W700,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(24),

                  // Branch Name
                  _buildTextField(
                    label: "Branch Name *",
                    controller: _branchNameController,
                    hint: "e.g., Downtown Branch",
                  ),
                  verticalSpace(16),

                  // Phone
                  _buildTextField(
                    label: "Phone Number *",
                    controller: _phoneController,
                    hint: "+20 123 456 789",
                    keyboardType: TextInputType.phone,
                  ),
                  verticalSpace(16),

                  // Address
                  _buildTextField(
                    label: "Address",
                    controller: _addressController,
                    hint: "Street, City",
                    maxLines: 2,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.map, color: AppColors.primaryDeafult),
                      onPressed: _pickLocation,
                    ),
                  ),
                  if (_selectedLocation != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        "Selected Location: ${_selectedLocation!.latitude.toStringAsFixed(6)}, ${_selectedLocation!.longitude.toStringAsFixed(6)}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  verticalSpace(24),


                  // Hours Section
                  Text("Operating Hours", style: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult)),
                  verticalSpace(12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: "Open",
                          controller: _openHourController,
                          hint: "09:00",
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildTextField(
                          label: "Close",
                          controller: _closeHourController,
                          hint: "22:00",
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(24),

                  // Delivery Section
                  Text("Delivery Settings", style: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult)),
                  verticalSpace(12),
                  _buildTextField(
                    label: "Delivery Cost",
                    controller: _deliveryCostController,
                    hint: "15",
                    keyboardType: TextInputType.number,
                    suffix: "EGP",
                  ),
                  verticalSpace(16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: "Prep Time",
                          controller: _preparationTimeController,
                          hint: "20",
                          keyboardType: TextInputType.number,
                          suffix: "min",
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildTextField(
                          label: "Delivery Time",
                          controller: _deliveryTimeController,
                          hint: "35",
                          keyboardType: TextInputType.number,
                          suffix: "min",
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      title: isEditing ? "Save Changes" : "Create Branch",
                      onPressed: _saveBranch,
                    ),
                  ),
                  verticalSpace(24),
                ],
              ),
            ),
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.bimini14W700.copyWith(color: Colors.black87)),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
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
