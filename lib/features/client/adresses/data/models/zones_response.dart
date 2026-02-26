import 'package:delveria/features/client/adresses/data/models/delivery_zone.dart';

class GetZonesResponse {
  final bool success;
  final int count;
  final List<DeliveryZone> zones;

  GetZonesResponse({
    required this.success,
    required this.count,
    required this.zones,
  });

  factory GetZonesResponse.fromJson(Map<String, dynamic> json) => GetZonesResponse(
    success: json['success'] ?? true,
    count: json['count'] ?? 0,
    zones: json['zones'] != null
        ? (json['zones'] as List).map((z) => DeliveryZone.fromJson(z)).toList()
        : [],
  );
}
