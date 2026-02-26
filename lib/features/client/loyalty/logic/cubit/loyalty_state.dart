import 'package:delveria/features/client/loyalty/data/models/loyalty_dashboard_response.dart';
import 'package:delveria/features/client/loyalty/data/models/loyalty_history_response.dart';
import 'package:delveria/features/client/loyalty/data/models/validate_code_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_state.freezed.dart';

@freezed
class LoyaltyState with _$LoyaltyState {
  const factory LoyaltyState.initial() = LoyaltyInitial;
  const factory LoyaltyState.loading() = LoyaltyLoading;
  const factory LoyaltyState.loaded(LoyaltyDashboard dashboard) = LoyaltyLoaded;
  const factory LoyaltyState.error(String message) = LoyaltyError;
  
  // History states
  const factory LoyaltyState.historyLoading() = LoyaltyHistoryLoading;
  const factory LoyaltyState.historyLoaded(LoyaltyHistoryData history) = LoyaltyHistoryLoaded;
  
  // Validate code states
  const factory LoyaltyState.validating() = LoyaltyValidating;
  const factory LoyaltyState.validated(ValidateCodeData codeData) = LoyaltyValidated;
  const factory LoyaltyState.validationFailed(String message) = LoyaltyValidationFailed;
}
