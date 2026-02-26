import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:delveria/features/client/loyalty/data/repo/loyalty_repo.dart';
import 'package:delveria/features/client/loyalty/logic/cubit/loyalty_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoyaltyCubit extends Cubit<LoyaltyState> {
  final LoyaltyRepo _loyaltyRepo;
  
  LoyaltyDashboard? _cachedDashboard;
  
  LoyaltyCubit(this._loyaltyRepo) : super(const LoyaltyState.initial());

  LoyaltyDashboard? get cachedDashboard => _cachedDashboard;

  /// Fetch the user's loyalty dashboard
  Future<void> fetchDashboard() async {
    emit(const LoyaltyState.loading());
    
    final result = await _loyaltyRepo.getDashboard();
    
    result.when(
      success: (response) {
        if (response.data != null) {
          _cachedDashboard = response.data;
          emit(LoyaltyState.loaded(response.data!));
        } else {
          emit(const LoyaltyState.error('No loyalty data found'));
        }
      },
      failure: (error) {
        emit(LoyaltyState.error(error.message ?? 'Failed to load loyalty data'));
      },
    );
  }

  /// Fetch points history
  Future<void> fetchHistory({int page = 1, int limit = 20}) async {
    emit(const LoyaltyState.historyLoading());
    
    final result = await _loyaltyRepo.getHistory(page: page, limit: limit);
    
    result.when(
      success: (response) {
        if (response.data != null) {
          emit(LoyaltyState.historyLoaded(response.data!));
        } else {
          emit(const LoyaltyState.error('No history found'));
        }
      },
      failure: (error) {
        emit(LoyaltyState.error(error.message ?? 'Failed to load history'));
      },
    );
  }

  /// Validate a loyalty code
  Future<bool> validateCode(String code) async {
    emit(const LoyaltyState.validating());
    
    final result = await _loyaltyRepo.validateCode(code);
    
    bool isValid = false;
    
    result.when(
      success: (response) {
        if (response.success == true && response.data != null) {
          emit(LoyaltyState.validated(response.data!));
          isValid = true;
        } else {
          emit(LoyaltyState.validationFailed(response.message ?? 'Invalid code'));
        }
      },
      failure: (error) {
        emit(LoyaltyState.validationFailed(error.message ?? 'Validation failed'));
      },
    );
    
    return isValid;
  }

  /// Get available (unused) reward codes
  List<EarnedReward> getAvailableCodes() {
    return _cachedDashboard?.earnedRewards
            ?.where((r) => r.isUsed != true)
            .toList() ??
        [];
  }

  /// Reset to dashboard state (after viewing history)
  void backToDashboard() {
    if (_cachedDashboard != null) {
      emit(LoyaltyState.loaded(_cachedDashboard!));
    } else {
      emit(const LoyaltyState.initial());
    }
  }
}
