import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/features/client/adresses/ui/widgets/mobile_number_text_field.dart';
import 'package:flutter/material.dart';

class ContactNumberSection extends StatelessWidget {
  const ContactNumberSection({super.key, required this.phoneController});
  final TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      

        verticalSpace(10),
        MobileNumberTextField(
          isAdmin: true,
          selectedCountryCode: '+20',
          phoneController: phoneController,
        ),
      ],
    );
  }
}
