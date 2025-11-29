import 'package:delveria/core/func/show_snack_bar.dart'; // Add this import for showWarningSnackBar
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdressCard extends StatelessWidget {
  const AdressCard({
    super.key,
    required this.index,
    required this.stateTheme,
    required this.addressCubit,
    required this.addressId,
  });
  final int index;
  final ThemeState stateTheme;
  final CreateAddressCubit addressCubit;
  final String addressId;

  @override
  Widget build(BuildContext context) {
    final address = addressCubit.addresses[index];

    // The last address in the list is considered the default
    final bool isDefault = address.isDefault;

    return GestureDetector(
      onTap: () async {
        await addressCubit.changeDefaultAdress(addressId: addressId);
        await addressCubit.getAdresses();
      },
      child: Card(
        color:
            stateTheme.themeMode == ThemeMode.dark
                ? null
                : isDefault
                ? Colors.white
                : AppColors.scaffoldGrey,
        margin: EdgeInsets.only(bottom: 16),
        elevation: isDefault ? 5 : 0,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                stateTheme.themeMode == ThemeMode.dark
                    ? null
                    : isDefault
                    ? Colors.white
                    : AppColors.scaffoldGrey,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isDefault ? Colors.red : AppColors.grey.withValues(alpha: .5),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      address.addressTitle,
                      style: TextStyles.bimini18W700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Prevent deleting the last address
                      if (addressCubit.addresses.length == 1) {
                        showWarningSnackBar(
                          context,
                          AppStrings.cannotDeleteAdress.tr(),
                        );
                        return;
                      }
                      print("❌ addresId $addressId");
                      await addressCubit.deleteAddress(addressId: addressId);
                      await addressCubit.getAdresses();
                    },
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          AppImages.trashRed,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                ],
              ),
              verticalSpace(20),
              Text(address.details, style: TextStyles.bimini13W400Grey),
            ],
          ),
        ),
      ),
    );
  }
}
