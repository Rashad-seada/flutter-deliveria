import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncreaseAndDecreaseBlocListener extends StatelessWidget {
  const IncreaseAndDecreaseBlocListener({
    super.key,
    required this.child,
    this.listenToIndex, 
  });

  final Widget child;
  final int? listenToIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToCartCubit, AddToCartState>(
      listenWhen: (previous, current) {
        
        return current.maybeWhen(
          increaseCartSuccess:
              (_, index) => listenToIndex == null || listenToIndex == index,
          increaseCartFail:
              (_, index) => listenToIndex == null || listenToIndex == index,
          decreaseCartSuccess:
              (_, index) => listenToIndex == null || listenToIndex == index,
          decreaseCartFail:
              (_, index) => listenToIndex == null || listenToIndex == index,
          orElse: () => false,
        );
      },
      listener: (context, state) {
        state.whenOrNull(
          increaseCartSuccess: (data, index) {
            if (listenToIndex == null || listenToIndex == index) {
              // showSuccessSnackBar(context, "Item increased successfully");
            }
          },
          increaseCartFail: (error, index) {
            if (listenToIndex == null || listenToIndex == index) {
              // showErrorSnackBar(context, error.message);
            }
          },
          decreaseCartSuccess: (data, index) {
            if (listenToIndex == null || listenToIndex == index) {
              // showSuccessSnackBar(context, "Item decreased successfully");
            }
          },
          decreaseCartFail: (error, index) {
            if (listenToIndex == null || listenToIndex == index) {
              // showErrorSnackBar(context, error.message);
            }
          },
        );
      },
      buildWhen: (previous, current) {
        
        return current.maybeWhen(
          increaseCartLoading:
              (index) => listenToIndex == null || listenToIndex == index,
          increaseCartSuccess:
              (_, index) => listenToIndex == null || listenToIndex == index,
          increaseCartFail:
              (_, index) => listenToIndex == null || listenToIndex == index,
          decreaseCartLoading:
              (index) => listenToIndex == null || listenToIndex == index,
          decreaseCartSuccess:
              (_, index) => listenToIndex == null || listenToIndex == index,
          decreaseCartFail:
              (_, index) => listenToIndex == null || listenToIndex == index,
          orElse: () => false,
        );
      },
      builder: (context, state) {
        
        final isLoading = state.maybeWhen(
          increaseCartLoading:
              (index) => listenToIndex == null || listenToIndex == index,
          decreaseCartLoading:
              (index) => listenToIndex == null || listenToIndex == index,
          orElse: () => false,
        );

        if (isLoading) {
          return CustomLoading();
        }

        return child;
      },
    );
  }
}
