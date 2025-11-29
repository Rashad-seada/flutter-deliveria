import 'dart:async';

import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/features/client/orders/logic/cubit/order_cubit.dart';
import 'package:delveria/features/client/orders/ui/widgets/delivered_on_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingOrderScreen extends StatefulWidget {
  final String? orderId;
  final String? initialOrderStatus;
  final String time;
  final bool useTimer;

  const TrackingOrderScreen({
    super.key,
    this.orderId,
    this.initialOrderStatus,
    this.useTimer = false,
    required this.time,
  });

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen>
    with TickerProviderStateMixin {
  late OrderCubit _orderCubit;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeOrderCubit();
  }

  void _initializeOrderCubit() {
    print(widget.initialOrderStatus);
    print(widget.orderId);
    final animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _orderCubit = OrderCubit(animationController: animationController);

    if (widget.initialOrderStatus != null) {
      _orderCubit.updateOrderStatus(widget.initialOrderStatus!);
    }

    _startAnimation();

    if (widget.useTimer) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_orderCubit.state.currentStep <
            _orderCubit.state.orderSteps.length - 1) {
          _orderCubit.nextStep();
        }
        _startAnimation();
      });
      _orderCubit.setTimer(_timer);
    }
  }

  void _refreshWholePage() {
    // Cancel timer and dispose old controller
    _timer?.cancel();
    _orderCubit.state.animationController.dispose();
    // Re-initialize cubit/timer and force rebuild
    setState(() {
      _initializeOrderCubit();
    });
  }

  void _startAnimation() {
    _orderCubit.state.animationController.reset();
    _orderCubit.state.animationController.forward();
  }

  void updateOrderStatus(String status) {
    _orderCubit.updateOrderStatus(status);
    _startAnimation();
  }

  @override
  void dispose() {
    _orderCubit.state.animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>.value(
      value: _orderCubit,
      child: BlocListener<OrderCubit, dynamic>(
        listener: (context, state) {
          if (!widget.useTimer) {
            _startAnimation();
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: ArrowBackAppBarWithTitle(
              showTitle: true,
              showRefresh: true,
              widget: IconButton(
                onPressed: _refreshWholePage, // This refreshes the whole page
                icon: Icon(Icons.refresh, color: AppColors.primaryDeafult),
              ),
              title: AppStrings.trackingYourOrder.tr(),
              titleStyle: TextStyles.bimini20W700.copyWith(
                color: AppColors.primaryDeafult,
              ),
            ),
          ),
          body: DeliveredOnBody(
            time: widget.time,
            initialStatus: widget.initialOrderStatus ?? "",
          ),
        ),
      ),
    );
  }
}
