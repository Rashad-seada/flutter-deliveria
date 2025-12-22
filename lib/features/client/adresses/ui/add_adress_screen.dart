import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/close_app_dialog.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_state.dart';
import 'package:delveria/features/client/adresses/ui/location_picker_screen.dart';
import 'package:delveria/features/client/adresses/ui/widgets/adress_title_text_field.dart';
import 'package:delveria/features/client/adresses/ui/widgets/details_adress_text_field.dart';
import 'package:delveria/features/client/adresses/ui/widgets/link_address_text_field.dart';
import 'package:delveria/features/client/adresses/ui/widgets/location_on-map_button.dart';
import 'package:delveria/features/client/adresses/ui/widgets/mobile_number_text_field.dart';
import 'package:delveria/features/client/adresses/ui/widgets/save_changes_and_discared_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreen extends StatefulWidget {
  final LatLng? location;
  final String? address;

  const AddAddressScreen({super.key, this.location, this.address});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  LatLng? _selectedLocation;
  String _selectedAddress = "No location selected";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  @override
  void initState() {
    super.initState();
    if (widget.location != null && widget.address != null) {
      _selectedLocation = widget.location;
      _selectedAddress = widget.address!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final cubit = context.read<AddressCubit>();
        cubit.updateLatLong(
          _selectedLocation!.latitude,
          _selectedLocation!.longitude,
        );
        cubit.state.titleController.text = _selectedAddress;

        cubit.state.linkController.text =
            '${_selectedLocation!.latitude.toStringAsFixed(6)},${_selectedLocation!.longitude.toStringAsFixed(6)}';
      });
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedLocation = result['location'] as LatLng?;
        _selectedAddress = result['address'] as String;
      });

      final cubit = context.read<AddressCubit>();

      // cubit.state.titleController.text = _selectedAddress;

      if (_selectedLocation != null) {
        cubit.state.linkController.text =
            '${_selectedLocation!.latitude.toStringAsFixed(6)},${_selectedLocation!.longitude.toStringAsFixed(6)}';
        cubit.updateLatLong(
          _selectedLocation!.latitude,
          _selectedLocation!.longitude,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ArrowBackAppBarWithTitle(
          showTitle: true,
          onBack: () {
            showDialog(
              context: context,
              builder: (context) {
                return CloseAppDialog();
              },
            );
          },
          title: AppStrings.addAdress.tr(),
          titleStyle: TextStyles.bimini20W700.copyWith(
            color: AppColors.primaryDeafult,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            return Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.addressTitle.tr(),
                  style: TextStyles.bimini16W400Body,
                ),
                verticalSpace(10),
                AddressTitleTextField(titleController: state.titleController),
                SizedBox(height: 24),

                verticalSpace(8),
                MobileNumberTextField(
                  selectedCountryCode: state.selectedCountryCode,
                  phoneController: state.phoneController,
                ),
                verticalSpace(24),
                Text(
                  AppStrings.detailedAddress.tr(),
                  style: TextStyles.bimini16W400Body,
                ),
                verticalSpace(8),
                DetailsAdressTextField(
                  detailsController: state.detailsController,
                ),
                verticalSpace(24),
                Text(
                  AppStrings.linkAddressText.tr(),
                  style: TextStyles.bimini16W400Body,
                ),
                SizedBox(height: 8),

                LinkAddressTextField(
                  addressLinkController: state.linkController,
                ),
                verticalSpace(20),

                LocationOnMapButton(onPressed: _pickLocation),
                verticalSpace(40),

                // SwitchRow(state: state),
                SizedBox(height: 40),

                SaveChangesAndDiscaredBtn(widget: widget, state: state),
              ],
            );
          },
        ),
      ),
    );
  }
}
