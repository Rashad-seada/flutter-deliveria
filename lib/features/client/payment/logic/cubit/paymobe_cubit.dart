import 'package:delveria/features/client/payment/logic/cubit/paymobe_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymobeCubit extends Cubit<PaymobeState> {
  PaymobeCubit() : super(PaymobeState.initial());
  String? paymobeToken;
}
