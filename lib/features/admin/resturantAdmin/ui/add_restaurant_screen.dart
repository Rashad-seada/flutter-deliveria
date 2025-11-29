import 'package:delveria/core/func/format_time_to_day_24hrs.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_request.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/add_resturant_bloc_listener.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/build_address_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/category_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/contact_number_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/description_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/opening_hours_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/resturant_name_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/upload_logo_section.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/upload_photo_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_url_extractor/url_extractor.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  String? selectedCategory;
  String selectedCountryCode = '+20';

  bool showCategoryDropdown = false;

  final List<String> countryCodes = ['+20', '+1', '+44', '+91'];

  // Add hasDelivery state
  bool hasDelivery = true;

  // Helper to format TimeOfDay to 24-hour string (no am/pm, just 24h)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
        canPop: true,
          onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
          showTitle: true,
          title: AppStrings.addNewResturant.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
        builder: (context, state) {
          final cubit = context.read<AllresturantsadminCubit>();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(35),
                UploadLogoSection(),
                verticalSpace(35),
                UploadPhotoSection(),
                verticalSpace(32),
                CategorySection(),
                verticalSpace(24),
                ResturantNameSection(
                  estimatedTimeController: cubit.estimatedTimeController,
                  nameController: cubit.nameController,
                  passwordController: cubit.passwordController,
                  deliveryCostController: cubit.deliveryCostController,
                ),
                verticalSpace(2),
                ContactNumberSection(phoneController: cubit.phoneController),
                verticalSpace(24),
                OpeningHoursSection(cubit: cubit),
                verticalSpace(32),
                DescriptionSection(
                  descriptionController: cubit.descriptionController,
                ),
                verticalSpace(32),
                BuildAddressSection(addressController: cubit.addressController),
                verticalSpace(24),
                // // Add the hasDelivery checkbox here
                // Row(
                //   children: [
                //     Checkbox(
                //       value: hasDelivery,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           hasDelivery = value ?? false;
                //         });
                //       },
                //     ),
                //     const Text('Has Delivery', style: TextStyle(fontSize: 16)),
                //   ],
                // ),
                verticalSpace(36),
                AddResturantBlocListener(
                  child: Center(
                    child: AppButton(
                      title: 'Add',
                  // Updated validation logic for the Add button onPressed method
                      onPressed: () async {
                        // Check if any super category is selected
                        if (cubit.selectedSuperCategories.isEmpty) {
                          showWarningSnackBar(
                            context,
                            "You must choose at least one super category",
                          );
                          return;
                        }

                        // Check if all selected super categories have subcategories selected
                        bool hasEmptySubcategories = false;
                        for (String superId
                            in cubit.selectedSuperCategories.keys) {
                          if (!cubit.selectedSubCategories.containsKey(
                                superId,
                              ) ||
                              cubit.selectedSubCategories[superId]!.isEmpty) {
                            hasEmptySubcategories = true;
                            break;
                          }
                        }

                        if (hasEmptySubcategories) {
                          showWarningSnackBar(
                            context,
                            "You must choose subcategories for all selected super categories",
                          );
                          return;
                        }

                        // Check if address is a valid URL
                        if (!cubit.addressController.text.startsWith("http")) {
                          showWarningSnackBar(
                            context,
                            "The Location must be url",
                          );
                          return;
                        }

                        // If we reach here, all validations passed
                        double latitude = 0;
                        double longitude = 0;

                        if (cubit.addressController.text.isNotEmpty) {
                          final coordinates =
                              await GoogleMapsUrlExtractor.processGoogleMapsUrl(
                                cubit.addressController.text,
                              );
                          if (coordinates != null) {
                            latitude = coordinates['latitude'] ?? 0;
                            longitude = coordinates['longitude'] ?? 0;
                          }
                        }

                        // Format openHour and closeHour in 24-hour format (HH:mm)
                        String openHour24 = formatTimeOfDay24(cubit.fromTime);
                        String closeHour24 = formatTimeOfDay24(cubit.toTime);

                        cubit.creatResturantWithPickedFiles(
                          CreatResturantRequest(
                            name: cubit.nameController.text,
                            superCategory: cubit.categoryIds, // Now a list
                            estimatedTime: cubit.estimatedTimeController.text,
                            latitude: latitude.toString(),
                            longitude: longitude.toString(),
                            subCategory:
                                cubit
                                    .subcategoryIds, // Now a list (empty when "All" is selected)
                            phone: cubit.phoneController.text,
                            openHour: openHour24, // 24-hour format
                            closeHour: closeHour24, // 24-hour format
                            aboutUs: cubit.descriptionController.text,
                            locationMap: cubit.addressController.text,
                            password: cubit.passwordController.text,
                            // haveDelivery: hasDelivery ? "true" : "false",
                            deliveryCost: "0",
                          ),
                        );
                      },
                    ),
                  ),
                ),
                verticalSpace(78),
              ],
            ),
          );
        },
      ),
    );
  }
}
