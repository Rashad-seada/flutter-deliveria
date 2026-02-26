import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/section_label.dart';
import 'package:delveria/features/client/adresses/ui/widgets/location_on-map_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuildAddressSection extends StatelessWidget {
  const BuildAddressSection({super.key, required this.addressController, this.onPickLocation});
  final TextEditingController addressController;
  final VoidCallback? onPickLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionLabel(AppStrings.detailedAddress.tr()),
        verticalSpace(8),
        TextField(
          controller: addressController,
          decoration: InputDecoration(
            hintText:AppStrings.enterDetailsAddress.tr(),
            hintStyle: TextStyles.bimini13W400Grey,
            suffixIcon: onPickLocation != null 
                ? IconButton(
                    icon: const Icon(Icons.map, color: Color(0xFFD32F2F)), // AppColors.primaryDeafult logic is red
                    onPressed: onPickLocation,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD32F2F)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        verticalSpace(16),

        // LocationOnMapButton(),
      ],
    );
  }
}
