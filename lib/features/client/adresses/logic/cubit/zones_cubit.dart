import 'package:delveria/features/client/adresses/data/models/delivery_zone.dart';
import 'package:delveria/features/client/adresses/data/repo/zones_repo.dart';
import 'package:delveria/features/client/adresses/logic/cubit/zones_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZonesCubit extends Cubit<ZonesState> {
  final ZonesRepo zonesRepo;
  List<DeliveryZone> _zones = [];

  ZonesCubit(this.zonesRepo) : super(ZonesInitial());

  List<DeliveryZone> get zones => _zones;

  /// Load all delivery zones for map visualization
  Future<void> loadZones() async {
    emit(ZonesLoading());
    final response = await zonesRepo.getAllZones();
    response.when(
      success: (data) {
        _zones = data.zones;
        print("📍 Loaded ${_zones.length} delivery zones");
        emit(ZonesLoaded(zones: _zones));
      },
      failure: (error) {
        print("🔥 Failed to load zones: ${error.message}");
        emit(ZonesError(error.message ?? 'Failed to load zones'));
      },
    );
  }

  /// Check if user's location is within a delivery zone
  Future<void> checkUserLocation(double lat, double lng) async {
    final response = await zonesRepo.checkLocation(lat: lat, lng: lng);
    response.when(
      success: (result) {
        print("📍 Zone check result: ${result.inZone} - ${result.message}");
        emit(ZonesLoaded(zones: _zones, checkResult: result));
      },
      failure: (error) {
        print("🔥 Zone check failed: ${error.message}");
        // Don't change zones, just emit error for check
        emit(ZonesLoaded(zones: _zones));
      },
    );
  }

  /// Clear the zone check result
  void clearCheckResult() {
    emit(ZonesLoaded(zones: _zones));
  }
}
