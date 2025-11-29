import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_request.dart';
import 'package:delveria/features/admin/coupons/data/models/get_all_coupon_response.dart';
import 'package:delveria/features/admin/coupons/data/repo/coupone_repo.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponeCubit extends Cubit<CouponeState> {
  final CouponeRepo couponeRepo;
  CouponeCubit(this.couponeRepo) : super(CouponeState.initial());
  TextEditingController couponeCodeController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController validNumberController = TextEditingController();
  String selectedResValue = "selectResturant".tr();
  String resturantId = "0";
  String messageOfCheck = "";
  List<CouponCode> coupons = [];

  void creatCoupone({required CouponeRequest request}) async {
    emit(CouponeState.loading());
    try {
      final res = await couponeRepo.creatCoupone(request: request);
      res.when(
        success: (couponeRes) {
          emit(CouponeState.success(couponeRes));
        },
        failure: (error) => emit(CouponeState.fail(error)),
      );
    } catch (e) {
      emit(CouponeState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void checkCoupone({required String code}) async {
    emit(CouponeState.checkLoading());
    try {
      final res = await couponeRepo.checkCoupone(code: code);
      res.when(
        success: (checkCouponeRes) {
          emit(CouponeState.checkSuccess(checkCouponeRes));
          messageOfCheck = checkCouponeRes.message;
        },
        failure: (error) => emit(CouponeState.checkFail(error)),
      );
    } catch (e) {
      emit(CouponeState.checkFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> getCouponse() async {
    emit(CouponeState.getCouponsLoading());
    try {
      final res = await couponeRepo.getCoupons();
      res.when(
        success: (checkCouponeRes) {
          coupons = checkCouponeRes.couponCodes;
          emit(CouponeState.getCouponsSuccess(checkCouponeRes));
        },
        failure: (error) => emit(CouponeState.getCouponsFail(error)),
      );
    } catch (e) {
      emit(CouponeState.getCouponsFail(ApiErrorHandler.handle(e)));
    }
  }

  Future<void> changeCouponStatus({required String couponeId}) async {
    emit(CouponeState.changeStatusLoading());
    try {
      final response = await couponeRepo.changeEnableCoupon(
        couponId: couponeId,
      );
      response.when(
        success: (usersRes) {
          emit(CouponeState.changeStatusSuccess(usersRes));
        },
        failure: (error) => emit(CouponeState.changeStatusFail(error)),
      );
    } catch (e) {
      emit(CouponeState.changeStatusFail(ApiErrorHandler.handle(e)));
    }
  }
  void updateSelectedRes({required String newVal, required String resId}) {
    selectedResValue = newVal;
    resturantId = resId;
  }
}
