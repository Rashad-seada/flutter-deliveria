import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:delveria/features/client/cart/ui/widgets/build_detail_row.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_drop_down/styled_drop_down.dart';

class OrderDetailsSection extends StatefulWidget {
  const OrderDetailsSection({super.key, required this.couponeAccepted});
  final bool couponeAccepted;

  @override
  State<OrderDetailsSection> createState() => _OrderDetailsSectionState();
}

class _OrderDetailsSectionState extends State<OrderDetailsSection> {
  
  String? _selectedAddressId;

  @override
  void initState() {
    super.initState();
    _loadSelectedAddressId();
  }

  Future<void> _loadSelectedAddressId() async {
    
    final id = await SharedPrefHelper.getString('selected_address_id');
    setState(() {
      _selectedAddressId = id;
    });
  }

  Future<void> _saveSelectedAddressId(String? addressId) async {
    if (addressId != null) {
      print("Saving Selected Address ID: $addressId");
      await SharedPrefHelper.setData('selected_address_id', addressId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, userState) {
        final userCubit = context.read<UserDataCubit>();
        return BlocBuilder<CreateAddressCubit, CreateAddressState>(
          builder: (context, addressState) {
            final addressCubit = context.read<CreateAddressCubit>();
            final addressTitles =
                addressCubit.addresses.map((e) => e.addressTitle).toList();

            
            final Map<String, String> titleToId = {
              for (var e in addressCubit.addresses) e.addressTitle: e.id,
            };

            
            final Map<String, String> idToTitle = {
              for (var e in addressCubit.addresses) e.id: e.addressTitle,
            };

            
            if (addressTitles.isNotEmpty &&
                (addressCubit.addressValue == null ||
                    !addressTitles.contains(addressCubit.addressValue))) {
              if (_selectedAddressId != null &&
                  idToTitle.containsKey(_selectedAddressId)) {
                
                addressCubit.addressValue = idToTitle[_selectedAddressId]!;
              } else {
                addressCubit.addressValue = addressTitles.first;
                _saveSelectedAddressId(titleToId[addressTitles.first]);
                _selectedAddressId = titleToId[addressTitles.first];
              }
            }

            void onAddressChanged(String? newValue) {
              setState(() {
                addressCubit.addressValue = newValue;
                _selectedAddressId = titleToId[newValue];
                print("Address changed to: $newValue");
                print("Mapped ID: ${titleToId[newValue]}");
                _saveSelectedAddressId(_selectedAddressId);
              });
            }

            if (addressState is GetAddressLoading) {
              return CustomLoading();
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: BlocBuilder<AddToCartCubit, AddToCartState>(
                  builder: (context, cartState) {
                    final cartCubit = context.read<AddToCartCubit>();
                    return BlocBuilder<CouponeCubit, CouponeState>(
                      builder: (context, state) {
                        return Column(
                          spacing: 20.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDetailRow(
                              AppStrings.clientName.tr(),
                              '${userCubit.firstName}${userCubit.lastName}',
                            ),
                            buildDetailRow(
                              AppStrings.mobileNumber.tr(),
                              userCubit.phone,
                            ),
                            BlocBuilder<ThemeCubit, ThemeState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppStrings.locations.tr(),
                                          style: TextStyles.bimini20W700
                                              .copyWith(
                                                color:
                                                    state.themeMode ==
                                                            ThemeMode.dark
                                                        ? AppColors.lightGrey
                                                        : AppColors.darkGrey,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 400.w,
                                      child: StyledDropDown(
                                        mainContainerColor: Colors.transparent,
                                        dropDownBodyColor: Colors.transparent,
                                        itemContainerColor:
                                            state.themeMode == ThemeMode.dark
                                                ? AppColors.darkGrey
                                                : AppColors.lightGrey,
                                        itemBuilder: (context, item, selected) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 150.w,
                                                child: Text(
                                                  item,
                                                  style:
                                                      TextStyles.bimini14W500,
                                                ),
                                              ),
                                              selected
                                                  ? Icon(
                                                    Icons.check,
                                                    color: AppColors.primary,
                                                  )
                                                  : SizedBox(),
                                            ],
                                          );
                                        },
                                        dropIcon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: AppColors.grey,
                                          size: 15.sp,
                                        ),
                                        valueTextStyle: TextStyles.bimini14W500
                                            .copyWith(color: AppColors.grey),
                                        value:
                                            addressCubit.addressValue ??
                                            (addressTitles.isNotEmpty
                                                ? addressTitles.first
                                                : ""),
                                        items: addressTitles,
                                        onChanged: (onChanged) {
                                          print(
                                            "Dropdown selected: $onChanged",
                                          );
                                          onAddressChanged(onChanged);
                                          print(
                                            "Current selected address id: $_selectedAddressId",
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            buildDetailRow(
                              AppStrings.subtotal.tr(),
                              " ${cartCubit.cartData?.final_price_without_delivery_cost?.toString() ?? ""} L.E",
                              isAccepted: state is CheckSuccess ? true : false,
                            ),
                            buildDetailRow(
                              AppStrings.shippingFees.tr(),
                              "${cartCubit.cartData?.final_delivery_cost?.toString() ?? ""} L.E",
                            ),
                            Divider(thickness: 1, color: Colors.grey),
                            buildDetailRow(
                              AppStrings.total.tr(),
                              state is CheckSuccess
                                  ? (cartCubit.cartData?.final_price != null
                                      ? ((cartCubit.cartData!.final_price)!)
                                          .toStringAsFixed(2)
                                      : "")
                                  : (cartCubit.cartData?.final_price != null
                                      ? "${cartCubit.cartData!.final_price!.toString().length > 5 ? cartCubit.cartData!.final_price!.toString().substring(0, 5) : cartCubit.cartData!.final_price!.toString()} L.E"
                                      : ""),
                              isTotal: true,
                            ),
                          ],
                        );
                      },
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
