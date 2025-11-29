import 'package:delveria/features/client/adresses/data/models/add_address_request.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getLocationPermission(BuildContext context, String? phone) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("Location services are disabled.");
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      print("Location permission denied.");
      return;
    }
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;
    print("Coordinates: ($latitude, $longitude)");

    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String locality = place.locality ?? "Unknown city";
      String country = place.country ?? "Unknown country";
      String name = place.name ?? "Unknown place";
      String address = "${place.street ?? ''}, $locality, $country";

      print("Place Name: $name");
      print("City: $locality");
      print("Country: $country");
      print("Full Address: $address");
      print("lat: $latitude");
      print("long: $longitude");

      final createAddressCubit = context.read<CreateAddressCubit>();
      createAddressCubit.createAddress(
        address: AddAddressRequest(
          addressTitle: locality,
          phone: phone ?? '',
          details: address,
          latitude: latitude.toString(),
          longitude: longitude.toString(),
          isDefault: true,
        ),
        context: context,
      );
    } else {
      print("No placemarks found for these coordinates.");
    }
  } catch (e) {
    print("Error fetching location or during reverse geocoding: $e");
  }
}
