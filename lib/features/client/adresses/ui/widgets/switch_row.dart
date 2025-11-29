import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchRow extends StatelessWidget {
  const SwitchRow({super.key, required this.state});
  final AddressState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: state.isDefault,
          onChanged: (value) {
            context.read<AddressCubit>().updateIsDefault(value);
          },
          activeColor: Colors.white,
          activeTrackColor: Colors.green,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[300],
        ),
        SizedBox(width: 12),
        Text(AppStrings.setAsDeafult.tr(), style: TextStyles.bimini16W400Body),
      ],
    );
  }
}
