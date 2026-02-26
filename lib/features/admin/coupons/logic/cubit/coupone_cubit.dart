import 'package:delveria/core/network/api_error_handler.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_request.dart';
import 'package:delveria/features/admin/coupons/data/models/get_all_coupon_response.dart';
import 'package:delveria/features/admin/coupons/data/repo/coupone_repo.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:delveria/features/admin/coupons/data/models/coupon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponeCubit extends Cubit<CouponeState> {
  final CouponeRepo couponeRepo;
  CouponeCubit(this.couponeRepo) : super(CouponeState.initial());
  
  // Controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController couponeCodeController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController validNumberController = TextEditingController(); // Usage Limit
  TextEditingController usagePerUserController = TextEditingController(text: "1");
  TextEditingController minOrderValueController = TextEditingController(text: "0");
  TextEditingController descriptionController = TextEditingController();
  
  // State variables
  String selectedResValue = "selectResturant".tr();
  String resturantId = "0"; // "Full" or specific ID
  List<String> selectedRestaurants = [];
  bool isAllRestaurants = false;
  String discountType = "bill"; // "bill" or "delivery"
  String couponType = "promotional";
  
  String messageOfCheck = "";
  List<Coupon> coupons = [];

  void creatCoupone({required String expiredDate}) async {
    if (!formKey.currentState!.validate()) return;
    
    emit(CouponeState.loading());
    
    final request = CouponeRequest(
      code: couponeCodeController.text,
      discountType: discountType,
      value: (discountType == 'delivery' && (int.tryParse(discountController.text) ?? 0) == 0) 
          ? 1 
          : (int.tryParse(discountController.text) ?? 0),
      expiredDate: expiredDate,
      description: descriptionController.text,
      usageLimit: int.tryParse(validNumberController.text),
      usagePerUserLimit: int.tryParse(usagePerUserController.text),
      minimumOrderValue: double.tryParse(minOrderValueController.text),
      applicableRestaurants: isAllRestaurants ? [] : (resturantId != "0" ? [resturantId] : []),
      couponType: couponType,
    );

    try {
      final res = await couponeRepo.creatCoupone(request: request);
      res.when(
        success: (couponeRes) {
          getCoupons(); // Refresh list
          emit(CouponeState.success(couponeRes));
          resetControllers();
        },
        failure: (error) => emit(CouponeState.fail(error)),
      );
    } catch (e) {
      emit(CouponeState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void updateCoupon({
    required String id,
    Map<String, dynamic>? updates,
  }) async {
    // If updates map is provided, use it directly (flexible partial update)
    // Otherwise, construct it from controllers (full update from form)
    
    Map<String, dynamic> data;
    
    if (updates != null) {
      data = updates;
    } else {
        if (!formKey.currentState!.validate()) return;
        
        // Build map from controllers
        data = {
          'code': couponeCodeController.text,
          'discount_type': discountType,
          'value': (discountType == 'delivery' && (int.tryParse(discountController.text) ?? 0) == 0) 
              ? 1 
              : (int.tryParse(discountController.text) ?? 0),
          // 'expired_date': expiredDate, // Needs to be passed or managed
          'description': descriptionController.text,
          'usage_limit': int.tryParse(validNumberController.text),
          'usage_per_user_limit': int.tryParse(usagePerUserController.text),
          'minimum_order_value': double.tryParse(minOrderValueController.text),
          'applicable_restaurants': isAllRestaurants ? [] : (resturantId != "0" ? [resturantId] : []),
          'coupon_type': couponType
        };
    }
    
    emit(CouponeState.loading());

    try {
      final res = await couponeRepo.updateCoupon(id: id, updates: data);
      res.when(
        success: (couponeRes) {
          getCoupons(); // Refresh list
          emit(CouponeState.success(couponeRes)); // Reusing success state
          if (updates == null) resetControllers(); // Only reset if it was a form update
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

  Future<void> getCoupons() async {
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
    // Optimistic update
    final index = coupons.indexWhere((c) => c.id == couponeId);
    if (index != -1) {
       // Create a copy with toggled status for UI responsiveness
       // Note: Coupon model might be immutable, so we'd ideally replace it
    }
    
    emit(CouponeState.changeStatusLoading());
    try {
      final response = await couponeRepo.toggleCouponStatus(id: couponeId);
      response.when(
        success: (isActive) {
          // Update local list
          final index = coupons.indexWhere((c) => c.id == couponeId);
          if (index != -1) {
             // Re-fetch or update local model? 
             // Ideally we update the specific item in the list
             getCoupons();
          }
          emit(CouponeState.changeStatusSuccess(isActive));
        },
        failure: (error) => emit(CouponeState.changeStatusFail(error)),
      );
    } catch (e) {
      emit(CouponeState.changeStatusFail(ApiErrorHandler.handle(e)));
    }
  }
  
  Future<void> deleteCoupon(String id) async {
    emit(CouponeState.loading());
    try {
      final res = await couponeRepo.deleteCoupon(id: id);
      res.when(
        success: (_) {
           coupons.removeWhere((c) => c.id == id);
           emit(CouponeState.getCouponsSuccess(GetAllCouponesResponse(couponCodes: coupons)));
        },
        failure: (error) => emit(CouponeState.fail(error)),
      );
    } catch (e) {
      emit(CouponeState.fail(ApiErrorHandler.handle(e)));
    }
  }

  void updateSelectedRes({required String newVal, required String resId}) {
    selectedResValue = newVal;
    resturantId = resId;
  }
  
  void initializeForEdit(Coupon coupon) {
    const defaultUuid = "00000000-0000-0000-0000-000000000000"; // Should match backend if needed, or handling logic
    
    couponeCodeController.text = coupon.code;
    
    discountType = coupon.discountType;
    if (discountType == 'delivery' && coupon.value == 1) {
        // Handle logic for free delivery representation if stored as 1
        discountController.text = "0"; 
    } else {
        discountController.text = coupon.value.toString();
    }
    
    // Handle specific fields
    couponType = coupon.couponType;
    descriptionController.text = coupon.description ?? "";
    validNumberController.text = coupon.usageLimit?.toString() ?? "";
    usagePerUserController.text = coupon.usagePerUserLimit?.toString() ?? "1";
    minOrderValueController.text = coupon.minimumOrderValue?.toString() ?? "0";
    
    // Handle Restaurants
    isAllRestaurants = coupon.applicableRestaurants.isEmpty;
    if (!isAllRestaurants) {
       // Ideally populate selectedRestaurants or restaurantId
       // For now, if only single selection is supported:
       if (coupon.applicableRestaurants.isNotEmpty) {
         resturantId = coupon.applicableRestaurants.first;
         // selectedResValue needs to be updated too if we want the dropdown to show it correctly
         // This might require finding the restaurant name from ID which isn't readily available here without lookups
       }
    } else {
        resturantId = "0";
    }
  }

  void resetControllers() {
    couponeCodeController.clear();
    discountController.clear();
    validNumberController.clear();
    usagePerUserController.text = "1";
    minOrderValueController.text = "0";
    descriptionController.clear();
    selectedRestaurants = [];
    isAllRestaurants = false;
    discountType = "bill";
    couponType = "promotional";
  }
}
