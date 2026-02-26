class ZoneCheckResult {
  final bool inZone;
  final String? zoneName;
  final String? zoneId;
  final String message;
  final String? nearbyZone;

  ZoneCheckResult({
    required this.inZone,
    this.zoneName,
    this.zoneId,
    required this.message,
    this.nearbyZone,
  });

  factory ZoneCheckResult.fromJson(Map<String, dynamic> json) => ZoneCheckResult(
    inZone: json['in_zone'] ?? false,
    zoneName: json['zone_name'],
    zoneId: json['zone_id'],
    message: json['message'] ?? '',
    nearbyZone: json['nearby_zone'],
  );

  Map<String, dynamic> toJson() => {
    'in_zone': inZone,
    'zone_name': zoneName,
    'zone_id': zoneId,
    'message': message,
    'nearby_zone': nearbyZone,
  };
}
