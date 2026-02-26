import 'package:delveria/features/client/adresses/data/models/delivery_zone.dart';
import 'package:delveria/features/client/adresses/data/models/zone_check_response.dart';

abstract class ZonesState {}

class ZonesInitial extends ZonesState {}

class ZonesLoading extends ZonesState {}

class ZonesLoaded extends ZonesState {
  final List<DeliveryZone> zones;
  final ZoneCheckResult? checkResult;

  ZonesLoaded({
    required this.zones,
    this.checkResult,
  });

  ZonesLoaded copyWith({
    List<DeliveryZone>? zones,
    ZoneCheckResult? checkResult,
  }) {
    return ZonesLoaded(
      zones: zones ?? this.zones,
      checkResult: checkResult ?? this.checkResult,
    );
  }
}

class ZonesError extends ZonesState {
  final String message;
  ZonesError(this.message);
}
