import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/client/adresses/data/models/delivery_zone.dart';
import 'package:delveria/features/client/adresses/logic/cubit/zones_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/zones_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = "";
  bool _isLoading = false;
  bool? _isInZone;
  String? _zoneName;

  static const LatLng _defaultLocation = LatLng(30.0444, 31.2357);

  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  Set<Polygon> _polygons = {};

  late ZonesCubit _zonesCubit;

  @override
  void initState() {
    super.initState();
    _zonesCubit = getIt<ZonesCubit>();
    _zonesCubit.loadZones();
    _getCurrentLocation();
  }

  void _buildZoneOverlays(List<DeliveryZone> zones) {
    _circles.clear();
    _polygons.clear();

    for (final zone in zones) {
      final color = zone.isPriority ? Colors.green : Colors.blue;

      if (zone.type == ZoneType.circular && zone.center != null) {
        _circles.add(Circle(
          circleId: CircleId(zone.id),
          center: zone.center!,
          radius: (zone.radiusKm ?? 5) * 1000, // km to meters
          fillColor: color.withOpacity(0.15),
          strokeColor: color,
          strokeWidth: 2,
        ));
      } else if (zone.type == ZoneType.polygon && zone.polygonPoints != null && zone.polygonPoints!.isNotEmpty) {
        _polygons.add(Polygon(
          polygonId: PolygonId(zone.id),
          points: zone.polygonPoints!,
          fillColor: color.withOpacity(0.15),
          strokeColor: color,
          strokeWidth: 2,
        ));
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showWarningSnackBar(context, AppStrings.locationPermissionDenied.tr());
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showErrorSnackBar(context, AppStrings.locationPermissionPermanentlyDenied.tr());
        setState(() => _isLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 14.0),
          ),
        );
      }

      await _updateSelectedLocation(currentLocation);
    } catch (e) {
      showErrorSnackBar(context, '${AppStrings.errorGettingLocation.tr()}: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateSelectedLocation(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: location,
          draggable: true,
          onDragEnd: _updateSelectedLocation,
          infoWindow: InfoWindow(title: AppStrings.selectedLocation.tr()),
        ),
      };
    });

    // Check if location is in zone
    _zonesCubit.checkUserLocation(location.latitude, location.longitude);

    await _getAddressFromCoordinates(location);
  }

  Future<void> _getAddressFromCoordinates(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        setState(() {
          _selectedAddress =
              "${place.street}, ${place.subLocality}, "
              "${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress =
            "Lat: ${location.latitude.toStringAsFixed(6)}, "
            "Lng: ${location.longitude.toStringAsFixed(6)}";
      });
    }
  }

  void _onMapTapped(LatLng location) {
    _updateSelectedLocation(location);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  void _confirmLocation() {
    if (_selectedLocation != null) {
      Navigator.of(context).pop({
        'location': _selectedLocation,
        'address': _selectedAddress,
      });
    } else {
      _showSnackBar(AppStrings.pleaseSelectLocationFirst.tr());
    }
  }

  void _zoomIn() {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.zoomIn());
    }
  }

  void _zoomOut() {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.zoomOut());
    }
  }

  Widget _buildZoneStatusIndicator(ZonesState state) {
    if (state is ZonesLoaded && state.checkResult != null) {
      final result = state.checkResult!;
      final isInZone = result.inZone;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isInZone ? Colors.green.shade50 : Colors.red.shade50,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isInZone ? Colors.green : Colors.red,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isInZone ? Icons.check_circle : Icons.warning,
              color: isInZone ? Colors.green : Colors.red,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                isInZone
                    ? '${AppStrings.deliveryAvailable.tr()}: ${result.zoneName ?? AppStrings.zone.tr()}'
                    : AppStrings.outsideDeliveryArea.tr(),
                style: TextStyles.bimini14W700.copyWith(
                  color: isInZone ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _zonesCubit,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: ArrowBackAppBarWithTitle(
            showTitle: true,
            title: AppStrings.addAdress.tr(),
          ),
        ),
        body: BlocConsumer<ZonesCubit, ZonesState>(
          listener: (context, state) {
            if (state is ZonesLoaded) {
              _buildZoneOverlays(state.zones);
              if (state.checkResult != null) {
                setState(() {
                  _isInZone = state.checkResult!.inZone;
                  _zoneName = state.checkResult!.zoneName;
                });
              }
            }
          },
          builder: (context, state) {
            // Build zone overlays when zones are loaded
            if (state is ZonesLoaded && _circles.isEmpty && _polygons.isEmpty) {
              _buildZoneOverlays(state.zones);
            }

            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: const CameraPosition(
                    target: _defaultLocation,
                    zoom: 10.0,
                  ),
                  onTap: _onMapTapped,
                  markers: _markers,
                  circles: _circles,
                  polygons: _polygons,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                ),

                // Floating action buttons
                Positioned(
                  top: 20,
                  right: 10,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'my_location',
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _getCurrentLocation,
                        tooltip: AppStrings.myLocation.tr(),
                        child: const Icon(Icons.my_location, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: 'zoom_in',
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _zoomIn,
                        tooltip: AppStrings.zoomIn.tr(),
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: 'zoom_out',
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _zoomOut,
                        tooltip: AppStrings.zoomOut.tr(),
                        child: const Icon(Icons.remove, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Loading indicator
                if (_isLoading || state is ZonesLoading)
                  CustomLoading(),

                // Zone status indicator at top
                Positioned(
                  top: 10,
                  left: 0,
                  right: 70,
                  child: _buildZoneStatusIndicator(state),
                ),

                // Bottom sheet
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.addressTitle.tr(),
                          style: TextStyles.bimini16W700,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selectedAddress,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        // Use my current location button
                        GestureDetector(
                          onTap: _getCurrentLocation,
                          child: Container(
                            width: 265.w,
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryDeafult.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: AppColors.primaryDeafult.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.my_location,
                                  color: AppColors.primaryDeafult,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  AppStrings.useMyCurrentLocation.tr(),
                                  style: TextStyles.bimini14W700.copyWith(
                                    color: AppColors.primaryDeafult,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(16),
                        // Confirm button - disabled when outside delivery zone
                        Opacity(
                          opacity: (_isInZone == true) ? 1.0 : 0.5,
                          child: AppButton(
                            title: AppStrings.confirm.tr(),
                            onPressed: (_isInZone == true) ? _confirmLocation : null,
                          ),
                        ),
                        if (_isInZone == false)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              AppStrings.pleaseSelectLocationInDeliveryZone.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.red.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
