import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
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

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContinueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state.themeMode == ThemeMode.dark ? null : AppColors.scaffoldGrey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: ArrowBackAppBarWithTitle(
              canPop: true,
              showTitle: true,
              title: AppStrings.myAddresses.tr(),
              titleStyle: TextStyles.bimini20W700.copyWith(
                color: AppColors.primaryDeafult,
              ),
              bgcolor: AppColors.scaffoldGrey,
              sucolor: AppColors.scaffoldGrey,
            ),
          ),
          body:
              isContinueAsGuest
                  ? ContinueAsGuestBody()
                  : Padding(
            padding: EdgeInsets.all(16.0),
            child: BlocConsumer<CreateAddressCubit, CreateAddressState>(
              builder: (context, addressState) {
                final cubit = context.read<CreateAddressCubit>();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        itemCount: cubit.addresses.length,
                        itemBuilder: (context, index) {
                          return AdressCard(
                            index: index,
                            stateTheme: state,
                            addressCubit: cubit,
                            addressId: cubit.addresses[index].id,
                          );
                        },
                      ),
                    ),
                    AppButton(
                      title: AppStrings.addAdress.tr(),
                      onPressed: () {
                                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                        (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create:
                                          (context) =>
                                              getIt<CreateAddressCubit>(),
                                    ),
                                    BlocProvider(
                                      create:
                                                  (context) =>
                                                      getIt<AddressCubit>(),
                                    ),
                                  ],
                                          child: AddAddressScreen(),
                                ),
                          ),
                        );
                      },
                    ),
                    verticalSpace(20),
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
          ),
        );
      },
    );
  }
}
