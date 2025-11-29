class Coupon {
  final String code;
  final DateTime expiryDate;
  final int discountPercentage;
  final List<String> restaurants;
   bool isValid;
   String status; 

  Coupon({
    required this.code,
    required this.expiryDate,
    required this.discountPercentage,
    required this.restaurants,
    required this.isValid,
    required this.status,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);
}

