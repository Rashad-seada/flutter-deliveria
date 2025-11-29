import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/widgets/customer_info_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerInfoSection extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? address;
  final String? addressDetails;
  final bool isDeliveryAgent;

  const CustomerInfoSection({
    Key? key,
    this.name,
    this.phone,
    this.address,
    this.addressDetails,
    required this.isDeliveryAgent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.customerInfo.tr(),
          style: TextStyles.bimini20W700.copyWith(
            color: isDeliveryAgent ? AppColors.primaryDeafult : null,
          ),
        ),
        verticalSpace(30),
        if (isDeliveryAgent)
          _buildDeliveryAgentInfo()
        else
          CustomerInfoRow(address: address, name: name, phone: phone),
      ],
    );
  }

  Widget _buildDeliveryAgentInfo() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.primaryDeafult, size: 22),
            const SizedBox(width: 10),
            Text(phone ?? "", style: TextStyles.bimini16W400Body),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.primaryDeafult,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address ?? "", style: TextStyles.bimini16W400Body),
                    if (addressDetails?.isNotEmpty == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          addressDetails ?? "",
                          style: TextStyles.bimini13W400Grey.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
