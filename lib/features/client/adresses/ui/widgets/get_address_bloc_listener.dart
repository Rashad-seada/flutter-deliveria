import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAddressBlocListener extends StatelessWidget {
  const GetAddressBlocListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAddressCubit, CreateAddressState>(
      listenWhen:
          (previous, current) =>
              current is GetAddressSuccess || current is GetAddressFail,

      listener: (context, state) {
        state.whenOrNull(
          getAddressFail: (error) {
            return Center(child: Text(error.message));
          },
        );
      },
      buildWhen:
          (previous, current) =>
              current is GetAddressLoading || current is! GetAddressLoading,

      builder: (context, state) {
        if (state is GetAddressLoading ||
            state.maybeWhen(
              getAddressLoading: () => true,
              orElse: () => false,
            )) {
          return CustomLoading();
        }
        return child;
      },
    );
  }
}
