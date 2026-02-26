import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/adresses/data/models/add_address_request.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_state.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/adresses/ui/add_adress_screen.dart';
import 'package:delveria/features/client/adresses/ui/widgets/create_address_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_url_extractor/url_extractor.dart';

class SaveChangesAndDiscaredBtn extends StatefulWidget {
  const SaveChangesAndDiscaredBtn({
    super.key,
    required this.widget,
    required this.state,
  });

  final AddAddressScreen widget;
  final AddressState state;

  @override
  State<SaveChangesAndDiscaredBtn> createState() =>
      _SaveChangesAndDiscaredBtnState();
}

class _SaveChangesAndDiscaredBtnState extends State<SaveChangesAndDiscaredBtn> {
  @override
  Widget build(BuildContext context) {
    return CreateAddressBlocListener(
      child: BlocBuilder<CreateAddressCubit, CreateAddressState>(
        builder: (context, addressState) {
          final cubit = context.read<CreateAddressCubit>();
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryDeafult.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.state.titleController.text.isNotEmpty &&
                          widget.state.detailsController.text.isNotEmpty &&
                          widget.state.phoneController.text.isNotEmpty) {
                        String url = widget.state.linkController.text;
                        double latitude = widget.state.lat;
                        double longitude = widget.state.long;

                        if (url.isNotEmpty) {
                          final coordinates =
                              await GoogleMapsUrlExtractor.processGoogleMapsUrl(url);
                          if (coordinates != null) {
                            latitude = coordinates['latitude'] ?? 0;
                            longitude = coordinates['longitude'] ?? 0;
                          }
                        }

                        cubit.createAddress(
                          address: AddAddressRequest(
                            addressTitle: widget.state.titleController.text,
                            phone: widget.state.phoneController.text,
                            details: widget.state.detailsController.text,
                            latitude: latitude.toString(),
                            longitude: longitude.toString(),
                            isDefault: true,
                          ),
                          context: context,
                        );
                      } else {
                        showWarningSnackBar(context, "يجب ملئ جميع الحقول ");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDeafult,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppStrings.saveChanges.tr(),
                      style: TextStyles.bimini16W700.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                   height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                         Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColors.primaryDeafult),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppStrings.discard.tr(),
                      style: TextStyles.bimini16W700.copyWith(
                        color: AppColors.primaryDeafult,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
