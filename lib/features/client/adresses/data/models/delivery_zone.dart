import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ZoneType { circular, polygon }

class DeliveryZone {
  final String id;
  final String name;
  final ZoneType type;
  final String description;
  final double deliveryFeeMultiplier;
  final bool isPriority;
  final LatLng? center;
  final double? radiusKm;
  final List<LatLng>? polygonPoints;

  DeliveryZone({
    required this.id,
    required this.name,
    required this.type,
    this.description = '',
    this.deliveryFeeMultiplier = 1.0,
    this.isPriority = false,
    this.center,
    this.radiusKm,
    this.polygonPoints,
  });

  factory DeliveryZone.fromJson(Map<String, dynamic> json) {
    final type = json['type'] == 'circular' ? ZoneType.circular : ZoneType.polygon;
    
    return DeliveryZone(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      type: type,
      description: json['description'] ?? '',
      deliveryFeeMultiplier: (json['delivery_fee_multiplier'] ?? 1.0).toDouble(),
      isPriority: json['is_priority'] ?? false,
      center: json['center'] != null
          ? LatLng(
              (json['center']['latitude'] ?? 0).toDouble(),
              (json['center']['longitude'] ?? 0).toDouble(),
            )
          : null,
      radiusKm: json['radius']?.toDouble(),
      polygonPoints: json['polygon'] != null && (json['polygon'] as List).isNotEmpty
          ? (json['polygon'] as List)
              .map((p) => LatLng(
                    (p['lat'] ?? 0).toDouble(),
                    (p['lng'] ?? 0).toDouble(),
                  ))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type == ZoneType.circular ? 'circular' : 'polygon',
    'description': description,
    'delivery_fee_multiplier': deliveryFeeMultiplier,
    'is_priority': isPriority,
    'center': center != null
        ? {'latitude': center!.latitude, 'longitude': center!.longitude}
        : null,
    'radius': radiusKm,
    'polygon': polygonPoints
        ?.map((p) => {'lat': p.latitude, 'lng': p.longitude})
        .toList(),
  };
}
