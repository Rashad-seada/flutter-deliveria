import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/arrow_back_app_bar.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = "No location selected";
  bool _isLoading = false;

  
  static const LatLng _defaultLocation = LatLng(30.0444, 31.2357);

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showWarningSnackBar(context,'Location permissions are denied');
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showErrorSnackBar(context,'Location permissions are permanently denied');
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
            CameraPosition(target: currentLocation, zoom: 30.0),
          ),
        );
      }

      
      await _updateSelectedLocation(currentLocation);
    } catch (e) {
      showErrorSnackBar(context,'Error getting current location: $e');
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
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      };
    });

    
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
      _showSnackBar('Please select a location first');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(60),
      child: ArrowBackAppBarWithTitle(showTitle: true, title: AppStrings.addAdress.tr(),)),
      body: Stack(
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
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false, 
            mapToolbarEnabled: false,
          ),

          
          Positioned(
            top: 20,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoom_in',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: _zoomIn,
                  tooltip: 'Zoom In',
                  child: const Icon(Icons.add, color: Colors.black),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoom_out',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: _zoomOut,
                  tooltip: 'Zoom Out',
                  child: const Icon(Icons.remove, color: Colors.black),
                ),
              ],
            ),
          ),

          
          if (_isLoading)
            CustomLoading(),

          
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    AppStrings.addressTitle.tr(),
                    style:TextStyles.bimini16W700
                  ),
                  const SizedBox(height: 8),
                  Text(_selectedAddress, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 16),
                  Center(
                    child: AppButton(
                      title: AppStrings.confirm.tr(),
                      onPressed: _confirmLocation,
                    ),
                  ),
              ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
