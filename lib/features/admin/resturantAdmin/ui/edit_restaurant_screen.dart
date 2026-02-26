import 'dart:io';

import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/features/client/adresses/ui/location_picker_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delveria/core/helper/image_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditRestaurantScreen extends StatefulWidget {
  final ResturantAdmin restaurant;

  const EditRestaurantScreen({super.key, required this.restaurant});

  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  late TextEditingController _nameController;
  late TextEditingController _aboutUsController;
  late TextEditingController _phoneController;
  late TextEditingController _openHourController;
  late TextEditingController _closeHourController;
  late TextEditingController _deliveryCostController;
  late TextEditingController _commissionController;
  late TextEditingController _preparationTimeController;
  late TextEditingController _deliveryTimeController;
  
  // Add location controller for address to be explicit about map location
  late TextEditingController _locationMapController;

  File? _newPhoto;
  File? _newLogo;
  LatLng? _selectedLocation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.restaurant.name ?? '');
    _aboutUsController = TextEditingController(text: widget.restaurant.aboutUs ?? '');
    _phoneController = TextEditingController(text: widget.restaurant.phone ?? '');
    _openHourController = TextEditingController(text: widget.restaurant.openHour ?? '');
    _closeHourController = TextEditingController(text: widget.restaurant.closeHour ?? '');
    _deliveryCostController = TextEditingController(text: widget.restaurant.deliveryCost?.toString() ?? '0');
    _commissionController = TextEditingController(text: widget.restaurant.commissionPercentage?.toString() ?? '0');
    _preparationTimeController = TextEditingController(text: widget.restaurant.preparationTime?.toString() ?? '15');
    _deliveryTimeController = TextEditingController(text: widget.restaurant.deliveryTime?.toString() ?? '30');
    _locationMapController = TextEditingController(text: widget.restaurant.locationMap ?? '');
    
    if (widget.restaurant.coordinates.latitude != null && widget.restaurant.coordinates.longitude != null) {
      final lat = (widget.restaurant.coordinates.latitude as num).toDouble();
      final lng = (widget.restaurant.coordinates.longitude as num).toDouble();
      _selectedLocation = LatLng(lat, lng);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutUsController.dispose();
    _phoneController.dispose();
    _openHourController.dispose();
    _closeHourController.dispose();
    _deliveryCostController.dispose();
    _commissionController.dispose();
    _preparationTimeController.dispose();
    _deliveryTimeController.dispose();
    _locationMapController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() => _newPhoto = File(result.files.single.path!));
      }
    } catch (e) {
      print("Error picking photo: $e");
    }
  }

  Future<void> _pickLogo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() => _newLogo = File(result.files.single.path!));
      }
    } catch (e) {
      print("Error picking logo: $e");
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
          _locationMapController.text = result['address'];
        }
      });
    }
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);

    try {
      final cubit = getIt<AllresturantsadminCubit>();
      final restaurantId = widget.restaurant.id;

      if (restaurantId == null) {
        showErrorSnackBar(context, "Restaurant ID is missing");
        return;
      }

      // Build update data
      final updateData = <String, dynamic>{
        'name': _nameController.text,
        'about_us': _aboutUsController.text,
        'phone': _phoneController.text,
        'open_hour': _openHourController.text,
        'close_hour': _closeHourController.text,
        'delivery_cost': _deliveryCostController.text,
        'location_map': _locationMapController.text,
        'commission_percentage': double.tryParse(_commissionController.text) ?? 0,
        'preparation_time': int.tryParse(_preparationTimeController.text) ?? 15,
        'delivery_time': int.tryParse(_deliveryTimeController.text) ?? 30,
      };
      
      if (_selectedLocation != null) {
        updateData['latitude'] = _selectedLocation!.latitude;
        updateData['longitude'] = _selectedLocation!.longitude;
      }

      // Update restaurant info
      final result = await cubit.resturantAdminRepo.updateResturant(
        restaurantId: restaurantId,
        updateData: updateData,
      );

      result.when(
        success: (data) async {
          // Upload new photo if selected
          if (_newPhoto != null) {
            final uploadRes = await cubit.resturantAdminRepo.uploadResturantPhoto(
              restaurantId: restaurantId,
              photo: _newPhoto!,
            );
            uploadRes.when(
              success: (res) {
                final path = res['data']?['photo'] as String?;
                if (path != null) {
                  print('📸 Photo Uploaded: ${ImageHelper.getRestaurantImageUrl(path)}');
                }
              },
              failure: (err) => print('❌ Photo Upload Failed: ${err.message}'),
            );
          }

          // Upload new logo if selected
          if (_newLogo != null) {
            final uploadRes = await cubit.resturantAdminRepo.uploadResturantLogo(
              restaurantId: restaurantId,
              logo: _newLogo!,
            );
             uploadRes.when(
              success: (res) {
                final path = res['data']?['logo'] as String?;
                if (path != null) {
                  print('🎨 Logo Uploaded: ${ImageHelper.getRestaurantImageUrl(path)}');
                }
              },
              failure: (err) => print('❌ Logo Upload Failed: ${err.message}'),
            );
          }

          if (!mounted) return;
          showSuccessSnackBar(context, "Restaurant updated successfully!");
          Navigator.pop(context, true); // Return true to indicate changes were made
        },
        failure: (error) {
           if (mounted) showErrorSnackBar(context, error.message ?? "Failed to update restaurant");
        },
      );
    } catch (e) {
      if (mounted) showErrorSnackBar(context, "Error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          title: "Edit Restaurant",
          titleStyle: TextStyles.bimini20W700.copyWith(color: AppColors.primaryDeafult),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo & Logo Section
                  _buildImageSection(),
                  verticalSpace(24),

                  // Basic Info
                  _buildTextField("Restaurant Name", _nameController),
                  verticalSpace(16),
                  _buildTextField("About Us", _aboutUsController, maxLines: 3),
                  verticalSpace(16),
                  _buildTextField("Phone", _phoneController, keyboardType: TextInputType.phone),
                  verticalSpace(16),
                  _buildTextField(
                    "Location / Address", 
                    _locationMapController, 
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
                       "Selected Coords: ${_selectedLocation!.latitude.toStringAsFixed(6)}, ${_selectedLocation!.longitude.toStringAsFixed(6)}",
                       style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                     ),
                   ),
                  verticalSpace(16),

                  // Hours
                  Row(
                    children: [
                      Expanded(child: _buildTextField("Open Hour", _openHourController)),
                      SizedBox(width: 16.w),
                      Expanded(child: _buildTextField("Close Hour", _closeHourController)),
                    ],
                  ),
                  verticalSpace(16),

                  _buildTextField("Delivery Cost", _deliveryCostController, keyboardType: TextInputType.number),
                  verticalSpace(24),

                  // Admin Settings Section
                  Text(
                    "Admin Settings",
                    style: TextStyles.bimini16W700.copyWith(color: AppColors.primaryDeafult),
                  ),
                  verticalSpace(16),
                  _buildTextField(
                    "Commission (%)",
                    _commissionController,
                    keyboardType: TextInputType.number,
                    suffix: "%",
                  ),
                  verticalSpace(16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          "Prep Time",
                          _preparationTimeController,
                          keyboardType: TextInputType.number,
                          suffix: "min",
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildTextField(
                          "Delivery Time",
                          _deliveryTimeController,
                          keyboardType: TextInputType.number,
                          suffix: "min",
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(32),

                  // Save Button
                  Center(
                    child: AppButton(
                      title: "Save Changes",
                      onPressed: _saveChanges,
                    ),
                  ),
                  verticalSpace(24),
                ],
              ),
            ),
    );
  }



  Widget _buildImageSection() {
    final photoUrl = ImageHelper.getRestaurantImageUrl(widget.restaurant.photo);
    final logoUrl = ImageHelper.getRestaurantImageUrl(widget.restaurant.logo);
    
    return Row(
      children: [
        // Photo
        Expanded(
          child: GestureDetector(
            onTap: _pickPhoto,
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: _newPhoto != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(_newPhoto!, fit: BoxFit.cover, width: double.infinity, height: 100.h),
                        )
                      : photoUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CachedNetworkImage(
                                imageUrl: photoUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 100.h,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            )
                          : Center(child: Icon(Icons.add_photo_alternate, size: 40.sp, color: Colors.grey)),
                ),
                SizedBox(height: 8.h),
                Text("Photo", style: TextStyles.bimini14W700),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Logo
        Expanded(
          child: GestureDetector(
            onTap: _pickLogo,
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: _newLogo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(_newLogo!, fit: BoxFit.cover, width: double.infinity, height: 100.h),
                        )
                      : logoUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CachedNetworkImage(
                                imageUrl: logoUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 100.h,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            )
                          : Center(child: Icon(Icons.add_photo_alternate, size: 40.sp, color: Colors.grey)),
                ),
                SizedBox(height: 8.h),
                Text("Logo", style: TextStyles.bimini14W700),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
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
