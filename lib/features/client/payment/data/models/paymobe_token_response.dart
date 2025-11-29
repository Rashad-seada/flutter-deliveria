import 'package:json_annotation/json_annotation.dart';

part 'paymobe_token_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymobeTokenResponse {
  final Profile? profile;
  final String? token;

  PaymobeTokenResponse({
    this.profile,
    this.token,
  });

  factory PaymobeTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymobeTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymobeTokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Profile {
  final int? id;
  final User? user;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final bool? active;
  @JsonKey(name: 'profile_type')
  final String? profileType;
  final List<String>? phones;
  @JsonKey(name: 'company_emails')
  final dynamic companyEmails;
  @JsonKey(name: 'company_name')
  final String? companyName;
  final String? state;
  final String? country;
  final String? city;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  final String? street;
  @JsonKey(name: 'email_notification')
  final bool? emailNotification;
  @JsonKey(name: 'order_retrieval_endpoint')
  final dynamic orderRetrievalEndpoint;
  @JsonKey(name: 'delivery_update_endpoint')
  final dynamic deliveryUpdateEndpoint;
  @JsonKey(name: 'logo_url')
  final dynamic logoUrl;
  @JsonKey(name: 'is_mobadra')
  final bool? isMobadra;
  final String? sector;
  @JsonKey(name: 'is_2fa_enabled')
  final bool? is2faEnabled;
  @JsonKey(name: 'otp_sent_to')
  final String? otpSentTo;
  @JsonKey(name: 'activation_method')
  final int? activationMethod;
  @JsonKey(name: 'signed_up_through')
  final int? signedUpThrough;
  @JsonKey(name: 'failed_attempts')
  final int? failedAttempts;
  @JsonKey(name: 'custom_export_columns')
  final List<dynamic>? customExportColumns;
  @JsonKey(name: 'server_IP')
  final List<dynamic>? serverIP;
  final String? username;
  @JsonKey(name: 'primary_phone_number')
  final String? primaryPhoneNumber;
  @JsonKey(name: 'primary_phone_verified')
  final bool? primaryPhoneVerified;
  @JsonKey(name: 'is_temp_password')
  final bool? isTempPassword;
  @JsonKey(name: 'otp_2fa_sent_at')
  final dynamic otp2faSentAt;
  @JsonKey(name: 'otp_2fa_attempt')
  final dynamic otp2faAttempt;
  @JsonKey(name: 'otp_sent_at')
  final String? otpSentAt;
  @JsonKey(name: 'otp_validated_at')
  final String? otpValidatedAt;
  @JsonKey(name: 'awb_banner')
  final dynamic awbBanner;
  @JsonKey(name: 'email_banner')
  final dynamic emailBanner;
  @JsonKey(name: 'identification_number')
  final dynamic identificationNumber;
  @JsonKey(name: 'delivery_status_callback')
  final String? deliveryStatusCallback;
  @JsonKey(name: 'merchant_external_link')
  final dynamic merchantExternalLink;
  @JsonKey(name: 'merchant_status')
  final int? merchantStatus;
  @JsonKey(name: 'deactivated_by_bank')
  final bool? deactivatedByBank;
  @JsonKey(name: 'bank_deactivation_reason')
  final dynamic bankDeactivationReason;
  @JsonKey(name: 'bank_merchant_status')
  final int? bankMerchantStatus;
  @JsonKey(name: 'national_id')
  final dynamic nationalId;
  @JsonKey(name: 'super_agent')
  final dynamic superAgent;
  @JsonKey(name: 'wallet_limit_profile')
  final dynamic walletLimitProfile;
  final dynamic address;
  @JsonKey(name: 'commercial_registration')
  final dynamic commercialRegistration;
  @JsonKey(name: 'commercial_registration_area')
  final dynamic commercialRegistrationArea;
  @JsonKey(name: 'distributor_code')
  final dynamic distributorCode;
  @JsonKey(name: 'distributor_branch_code')
  final dynamic distributorBranchCode;
  @JsonKey(name: 'allow_terminal_order_id')
  final bool? allowTerminalOrderId;
  @JsonKey(name: 'allow_encryption_bypass')
  final bool? allowEncryptionBypass;
  @JsonKey(name: 'wallet_phone_number')
  final dynamic walletPhoneNumber;
  final int? suspicious;
  final dynamic latitude;
  final dynamic longitude;
  @JsonKey(name: 'bank_staffs')
  final Map<String, dynamic>? bankStaffs;
  @JsonKey(name: 'bank_rejection_reason')
  final dynamic bankRejectionReason;
  @JsonKey(name: 'bank_received_documents')
  final bool? bankReceivedDocuments;
  @JsonKey(name: 'bank_merchant_digital_status')
  final int? bankMerchantDigitalStatus;
  @JsonKey(name: 'bank_digital_rejection_reason')
  final dynamic bankDigitalRejectionReason;
  @JsonKey(name: 'filled_business_data')
  final bool? filledBusinessData;
  @JsonKey(name: 'day_start_time')
  final String? dayStartTime;
  @JsonKey(name: 'day_end_time')
  final dynamic dayEndTime;
  @JsonKey(name: 'withhold_transfers')
  final bool? withholdTransfers;
  @JsonKey(name: 'manual_settlement')
  final bool? manualSettlement;
  @JsonKey(name: 'sms_sender_name')
  final String? smsSenderName;
  @JsonKey(name: 'withhold_transfers_reason')
  final dynamic withholdTransfersReason;
  @JsonKey(name: 'withhold_transfers_notes')
  final dynamic withholdTransfersNotes;
  @JsonKey(name: 'can_bill_deposit_with_card')
  final bool? canBillDepositWithCard;
  @JsonKey(name: 'can_topup_merchants')
  final bool? canTopupMerchants;
  @JsonKey(name: 'topup_transfer_id')
  final dynamic topupTransferId;
  @JsonKey(name: 'referral_eligible')
  final bool? referralEligible;
  @JsonKey(name: 'is_eligible_to_be_ranger')
  final bool? isEligibleToBeRanger;
  @JsonKey(name: 'eligible_for_manual_refunds')
  final bool? eligibleForManualRefunds;
  @JsonKey(name: 'is_ranger')
  final bool? isRanger;
  @JsonKey(name: 'is_poaching')
  final bool? isPoaching;
  @JsonKey(name: 'paymob_app_merchant')
  final bool? paymobAppMerchant;
  @JsonKey(name: 'settlement_frequency')
  final dynamic settlementFrequency;
  @JsonKey(name: 'day_of_the_week')
  final dynamic dayOfTheWeek;
  @JsonKey(name: 'day_of_the_month')
  final dynamic dayOfTheMonth;
  @JsonKey(name: 'allow_transaction_notifications')
  final bool? allowTransactionNotifications;
  @JsonKey(name: 'allow_transfer_notifications')
  final bool? allowTransferNotifications;
  @JsonKey(name: 'sallefny_amount_whole')
  final int? sallefnyAmountWhole;
  @JsonKey(name: 'sallefny_fees_whole')
  final int? sallefnyFeesWhole;
  @JsonKey(name: 'paymob_app_first_login')
  final dynamic paymobAppFirstLogin;
  @JsonKey(name: 'paymob_app_last_activity')
  final dynamic paymobAppLastActivity;
  @JsonKey(name: 'payout_enabled')
  final bool? payoutEnabled;
  @JsonKey(name: 'payout_terms')
  final bool? payoutTerms;
  @JsonKey(name: 'is_bills_new')
  final bool? isBillsNew;
  @JsonKey(name: 'can_process_multiple_refunds')
  final bool? canProcessMultipleRefunds;
  @JsonKey(name: 'settlement_classification')
  final int? settlementClassification;
  @JsonKey(name: 'instant_settlement_enabled')
  final bool? instantSettlementEnabled;
  @JsonKey(name: 'instant_settlement_transaction_otp_verified')
  final bool? instantSettlementTransactionOtpVerified;
  @JsonKey(name: 'preferred_language')
  final dynamic preferredLanguage;
  @JsonKey(name: 'ignore_flash_callbacks')
  final bool? ignoreFlashCallbacks;
  @JsonKey(name: 'receive_callback_card_info')
  final bool? receiveCallbackCardInfo;
  @JsonKey(name: 'acq_partner')
  final dynamic acqPartner;
  final dynamic dom;
  @JsonKey(name: 'bank_related')
  final dynamic bankRelated;
  final List<dynamic>? permissions;

  Profile({
    this.id,
    this.user,
    this.createdAt,
    this.active,
    this.profileType,
    this.phones,
    this.companyEmails,
    this.companyName,
    this.state,
    this.country,
    this.city,
    this.postalCode,
    this.street,
    this.emailNotification,
    this.orderRetrievalEndpoint,
    this.deliveryUpdateEndpoint,
    this.logoUrl,
    this.isMobadra,
    this.sector,
    this.is2faEnabled,
    this.otpSentTo,
    this.activationMethod,
    this.signedUpThrough,
    this.failedAttempts,
    this.customExportColumns,
    this.serverIP,
    this.username,
    this.primaryPhoneNumber,
    this.primaryPhoneVerified,
    this.isTempPassword,
    this.otp2faSentAt,
    this.otp2faAttempt,
    this.otpSentAt,
    this.otpValidatedAt,
    this.awbBanner,
    this.emailBanner,
    this.identificationNumber,
    this.deliveryStatusCallback,
    this.merchantExternalLink,
    this.merchantStatus,
    this.deactivatedByBank,
    this.bankDeactivationReason,
    this.bankMerchantStatus,
    this.nationalId,
    this.superAgent,
    this.walletLimitProfile,
    this.address,
    this.commercialRegistration,
    this.commercialRegistrationArea,
    this.distributorCode,
    this.distributorBranchCode,
    this.allowTerminalOrderId,
    this.allowEncryptionBypass,
    this.walletPhoneNumber,
    this.suspicious,
    this.latitude,
    this.longitude,
    this.bankStaffs,
    this.bankRejectionReason,
    this.bankReceivedDocuments,
    this.bankMerchantDigitalStatus,
    this.bankDigitalRejectionReason,
    this.filledBusinessData,
    this.dayStartTime,
    this.dayEndTime,
    this.withholdTransfers,
    this.manualSettlement,
    this.smsSenderName,
    this.withholdTransfersReason,
    this.withholdTransfersNotes,
    this.canBillDepositWithCard,
    this.canTopupMerchants,
    this.topupTransferId,
    this.referralEligible,
    this.isEligibleToBeRanger,
    this.eligibleForManualRefunds,
    this.isRanger,
    this.isPoaching,
    this.paymobAppMerchant,
    this.settlementFrequency,
    this.dayOfTheWeek,
    this.dayOfTheMonth,
    this.allowTransactionNotifications,
    this.allowTransferNotifications,
    this.sallefnyAmountWhole,
    this.sallefnyFeesWhole,
    this.paymobAppFirstLogin,
    this.paymobAppLastActivity,
    this.payoutEnabled,
    this.payoutTerms,
    this.isBillsNew,
    this.canProcessMultipleRefunds,
    this.settlementClassification,
    this.instantSettlementEnabled,
    this.instantSettlementTransactionOtpVerified,
    this.preferredLanguage,
    this.ignoreFlashCallbacks,
    this.receiveCallbackCardInfo,
    this.acqPartner,
    this.dom,
    this.bankRelated,
    this.permissions,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class User {
  final int? id;
  final String? username;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'date_joined')
  final String? dateJoined;
  final String? email;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'is_staff')
  final bool? isStaff;
  @JsonKey(name: 'is_superuser')
  final bool? isSuperuser;
  @JsonKey(name: 'last_login')
  final dynamic lastLogin;
  final List<dynamic>? groups;
  @JsonKey(name: 'user_permissions')
  final List<int>? userPermissions;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.dateJoined,
    this.email,
    this.isActive,
    this.isStaff,
    this.isSuperuser,
    this.lastLogin,
    this.groups,
    this.userPermissions,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
