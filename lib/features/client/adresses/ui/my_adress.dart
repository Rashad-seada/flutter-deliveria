import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/continue_as_guest_body.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/adresses/ui/add_adress_screen.dart';
import 'package:delveria/features/client/adresses/ui/widgets/adress_card.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  void initState() {
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;

        return Scaffold(
          backgroundColor:
              isDark ? null : const Color(0xFFF5F6FA),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: ArrowBackAppBarWithTitle(
              canPop: true,
              showTitle: true,
              title: AppStrings.myAddresses.tr(),
              titleStyle: TextStyles.bimini20W700.copyWith(
                color: AppColors.primaryDeafult,
              ),
              bgcolor: const Color(0xFFF5F6FA),
              sucolor: const Color(0xFFF5F6FA),
            ),
          ),
          body: isContinueAsGuest
              ? ContinueAsGuestBody()
              : BlocConsumer<CreateAddressCubit, CreateAddressState>(
                  builder: (context, addressState) {
                    final cubit = context.read<CreateAddressCubit>();
                    final hasAddresses = cubit.addresses.isNotEmpty;

                    return Column(
                      children: [
                        // Address count header
                        if (hasAddresses)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 8.h,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDeafult
                                        .withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    "${cubit.addresses.length}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryDeafult,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  AppStrings.myAddresses.tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Address list or empty state
                        Expanded(
                          child: hasAddresses
                              ? ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  itemCount: cubit.addresses.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: AdressCard(
                                        index: index,
                                        stateTheme: state,
                                        addressCubit: cubit,
                                        addressId:
                                            cubit.addresses[index].id,
                                      ),
                                    );
                                  },
                                )
                              : _buildEmptyState(isDark),
                        ),

                        // Add address button
                        SafeArea(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, -2),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                getIt<CreateAddressCubit>(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                getIt<AddressCubit>(),
                                          ),
                                        ],
                                        child: AddAddressScreen(),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.add_location_alt_rounded,
                                  size: 20.sp,
                                ),
                                label: Text(
                                  AppStrings.addAdress.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryDeafult,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  listener: (
                    BuildContext context,
                    CreateAddressState<dynamic> state,
                  ) {
                    state.whenOrNull(
                      deleteAddressSuccess: (data) {
                        showSuccessSnackBar(
                          context,
                          "Address deleted successfully",
                        );
                      },
                      changeEnableAddressSuccess: (data) {
                        showSuccessSnackBar(
                          context,
                          AppStrings.success.tr(),
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.primaryDeafult.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_off_rounded,
              size: 36.sp,
              color: AppColors.primaryDeafult.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.noAddressesYet.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              AppStrings.addYourFirstAddress.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.grey[500] : Colors.grey[500],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
