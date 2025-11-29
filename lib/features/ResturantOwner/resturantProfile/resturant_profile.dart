import 'dart:io';

import 'package:custom_form_w/custom_form_w.dart';
import 'package:delveria/core/func/format_time_to_day_24hrs.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_state.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_request.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/opening_hours_section.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/info_item_for_profile.dart';
import 'package:delveria/features/client/accountInfo/ui/widgets/stacked_profile_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantProfile extends StatefulWidget {
  const ResturantProfile({super.key});

  @override
  State<ResturantProfile> createState() => _ResturantProfileState();
}

class _ResturantProfileState extends State<ResturantProfile> {
  // Helper to check if file path is valid and on disk (and not an url).
  bool _isValidLocalFile(String? path) {
    // Must not be null, not empty, not start with http, and must exist on device storage
    if (path == null || path.isEmpty) return false;
    if (path.startsWith('http')) return false;
    try {
      final file = File(path);
      return file.existsSync();
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResturantProfileDataCubit, ResturantProfileDataState>(
      builder: (context, resState) {
        return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
          builder: (context, state) {
            final dateCubit = context.watch<AllresturantsadminCubit>();
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: ArrowBackAppBarWithTitle(
                  showTitle: true,
                  update: true,
                  onUpdateTap: () {
                    context.read<ResturantProfileDataCubit>().toggleUpdate();
                    setState(() {});
                  },
                  canPop: false,
                  title: AppStrings.profile.tr(),
                  titleStyle: TextStyles.bimini20W700.copyWith(
                    color: AppColors.primaryDeafult,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<
                  ResturantProfileDataCubit,
                  ResturantProfileDataState
                >(
                  builder: (context, state) {
                    final cubit = context.watch<ResturantProfileDataCubit>();
                    return SingleChildScrollView(
                      child: Column(
                        spacing: 30.h,
                        children: [
                          SizedBox(height: 10),
                          StackedProfileImage(
                            isResturant: true,
                            img: cubit.logo,
                          ),
                          verticalSpace(1),
                          cubit.isUpdate == true
                              ? CustomFormW(
                                  showButton: false,
                                  padding: EdgeInsetsGeometry.zero,
                                  children: [
                                    CustomTextField(
                                      controller: cubit.nameController,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      headerTextStyle:
                                          TextStyles.bimini16W400Body,
                                      headerText: AppStrings.restaurantName.tr(),
                                      hint: "Enter restaurnt name ",
                                      hintStyle: TextStyles.bimini13W400Grey,
                                    ),
                                  ],
                                )
                              : InfoItemForProfile(
                                  isResturant: true,
                                  icon: Icons.person_outline,
                                  label: AppStrings.restaurantName.tr(),
                                  value: cubit.name,
                                  iconColor: Colors.red[800]!,
                                ),
                          InfoItemForProfile(
                            isResturant: true,
                            icon: Icons.location_on_outlined,
                            label: AppStrings.address.tr(),
                            value: cubit.address,
                            iconColor: Colors.red[800]!,
                          ),
                          InfoItemForProfile(
                            isResturant: true,
                            icon: Icons.phone_outlined,
                            label: AppStrings.contactNumber.tr(),
                            value: cubit.phone,
                            iconColor: Colors.red[800]!,
                          ),
                          cubit.isUpdate == true
                              ? OpeningHoursSection(cubit: dateCubit)
                              : InfoItemForProfile(
                                  isResturant: true,
                                  icon: Icons.access_time_rounded,
                                  label: AppStrings.operatingHour.tr(),
                                  value: "${cubit.openHour}__${cubit.closeHour}",
                                  iconColor: Colors.red[800]!,
                                ),
                          cubit.isUpdate == true
                              ? state is UpdateLoading
                                  ? CustomLoading()
                                  : state is UpdateFail
                                      ? Text("Fail")
                                      : AppButton(
                                          title: AppStrings.saveChanges,
                                          onPressed: () async {
                                            final profileCubit = context.read<ResturantProfileDataCubit>();
                                            final dateCubit = context.read<AllresturantsadminCubit>();
                                            String openHour24 = formatTimeOfDay24(
                                              dateCubit.fromTime,
                                            );
                                            String closeHour24 = formatTimeOfDay24(
                                              dateCubit.toTime,
                                            );

                                            // Use the helper to only load file if file exists
                                            File? photoFile;
                                            File? logoFile;

                                            if (_isValidLocalFile(profileCubit.photo)) {
                                              photoFile = File(profileCubit.photo!);
                                            } else {
                                              photoFile = null;
                                            }

                                            if (_isValidLocalFile(profileCubit.logo)) {
                                              logoFile = File(profileCubit.logo!);
                                            } else {
                                              logoFile = null;
                                            }

                                            await profileCubit.updateRestaurantData(
                                              CreatResturantRequest(
                                                name: profileCubit.nameController.text.isNotEmpty
                                                    ? profileCubit.nameController.text
                                                    : profileCubit.name,
                                                superCategory: profileCubit.superCategories,
                                                estimatedTime: profileCubit.estimatedTime,
                                                latitude: profileCubit.lat.toString(),
                                                longitude: profileCubit.long.toString(),
                                                subCategory: profileCubit.subCategories,
                                                phone: profileCubit.phone,
                                                openHour: openHour24,
                                                closeHour: closeHour24,
                                                aboutUs: profileCubit.aboutUs,
                                                locationMap: profileCubit.locationMap,
                                                password: profileCubit.password,
                                                // haveDelivery: hasDelivery ? "true" : "false",
                                                deliveryCost: "0",
                                              ),
                                              photoFile,
                                              logoFile,
                                              profileCubit.id ?? "",
                                            );
                                          },
                                        )
                              : SizedBox(),
                          cubit.isUpdate == true
                              ? verticalSpace(20)
                              : verticalSpace(10),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
