import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';

LocationPermission? permission;
Position? position;
double? latitude;
double? longitude;
String? finalAddress;

final CameraPosition initialLocation = CameraPosition(target: LatLng(latitude ?? 0.0, longitude ?? 0.0));
late GoogleMapController mapController;

Set<Marker> markers = {};
String currentAddress = '';
String destinationAddress = '';

final destinationAddressFocusNode = FocusNode();

/// =================== Location Permission =================== ///
Future<void> permissions() async {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    log('Location permissions are denied');
  }

  log("location latitude :: ${Constant.storage.read("latitude")}");
  log("location longitude :: ${Constant.storage.read("longitude")}");

  position =
      Constant.storage.read("latitude") == null || Constant.storage.read("longitude") == null ? await getDeviceLocation() : null;

  buildFullAddressFromLatLong(Constant.storage.read("latitude"), Constant.storage.read("longitude"));
}

Future<Position> getDeviceLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;
    log("Latitude :: $latitude");
    log("Longitude :: $longitude");

    Constant.storage.write("latitude", latitude);
    Constant.storage.write("longitude", longitude);

    log("latitude latitude :: ${Constant.storage.read("latitude")}");
    log("Longitude Longitude :: ${Constant.storage.read("longitude")}");

    return position;
  } catch (e) {
    log("Error getting location: $e");

    return Position(
      latitude: 0.0,
      longitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }
}

/// =================== Get Location From map =================== ///

HomeScreenController homeScreenController = Get.find<HomeScreenController>();

Future<Position> getUserLocationPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();
  if (!serviceEnabled) {
    log("Services Enabled :: $serviceEnabled");
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
      throw 'Location Permission Denied';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Location Permission Denied Permanently';
  }

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
    return value;
  }).catchError((e) async {
    return await Geolocator.getLastKnownPosition().then((value) async {
      if (value != null) {
        return value;
      } else {
        throw 'Enable Location';
      }
    }).catchError((e) {
      log("Error in get current position : $e");
      Utils.showToast(Get.context!, e);
      return e;
    });
  });
}

Future<String> buildFullAddressFromLatLong(double latitude, double longitude) async {
  List<Placemark> placeMark = await placemarkFromCoordinates(latitude, longitude).catchError((e) async {
    log("Error in Build Full Address :: $e");
    throw e;
  });

  Placemark place = placeMark[0];

  log("Place Json Object :: ${place.toJson().toString()}");

  String address = '';

  if (place.name != place.street) address = '${place.name} ';
  address = '$address${place.street}';
  address = '$address, ${place.locality}';
  address = '$address, ${place.administrativeArea}';
  address = '$address, ${place.postalCode}';
  address = '$address, ${place.country}';

  log("Get Address :: $address");

  finalAddress = address;
  log("Final Address :: $finalAddress");

  Constant.storage.write("latitude", latitude);
  Constant.storage.write("longitude", longitude);

  Constant.storage.write("userAddress", finalAddress);
  Constant.storage.write("currentCity", place.locality);
  log("User Address :: ${Constant.storage.read("userAddress")}");
  log("currentCity :: ${Constant.storage.read("currentCity")}");

  homeScreenController.update([Constant.idGetLocation]);

  return finalAddress ?? "";
}

getCurrentLocation() async {
  await getUserLocationPosition().then((position) async {
    setAddress();

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18.0),
      ),
    );

    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(currentAddress),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(title: 'Start $currentAddress', snippet: destinationAddress),
      icon: BitmapDescriptor.defaultMarker,
    ));

    Constant.storage.write("latitude", position.latitude);
    Constant.storage.write("longitude", position.longitude);

    String? city = await getCityName(position.latitude, position.longitude);
    log("User's Current City: $city");

    Constant.storage.write("userAddress", currentAddress);
    Constant.storage.write("currentCity", city);

    homeScreenController.update([Constant.idGetLocation]);
  }).catchError((e) {
    log("Catch Error in Get Current Location :: $e");
  });
}

Future<String?> getCityName(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      return placemarks.first.locality;
    }
  } catch (e) {
    log("Error getting city: $e");
  }
  return null;
}

Future<void> setAddress() async {
  try {
    Position position = await getUserLocationPosition().catchError((e) {
      log("Set Address in try");
      Utils.showToast(Get.context!, e);
      return e;
    });

    currentAddress = await buildFullAddressFromLatLong(position.latitude, position.longitude).catchError((e) {
      log("Catch Error in save Current Address");
      return e;
    });
    finalAddress = currentAddress;
    destinationAddress = currentAddress;

    Constant.storage.write("latitude", position.latitude);
    Constant.storage.write("longitude", position.longitude);

    Constant.storage.write("userAddress", destinationAddress);
    log("User Address :: ${Constant.storage.read("userAddress")}");

    homeScreenController.update([Constant.idGetLocation]);

    homeScreenController.update([Constant.idGetLocation]);
  } catch (e) {
    log("Error in Set Address :: $e");
  }
}

onHandleTapPoint(LatLng point) async {
  markers.clear();
  markers.add(
    Marker(
      markerId: MarkerId(point.toString()),
      position: point,
      infoWindow: InfoWindow(title: 'Start $currentAddress', snippet: destinationAddress),
      icon: BitmapDescriptor.defaultMarker,
    ),
  );

  mapController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: point,
        zoom: 18.0,
      ),
    ),
  );

  finalAddress = await buildFullAddressFromLatLong(point.latitude, point.longitude).catchError((e) {
    log("Catch Error in get Destination Address :: $e");
    return e;
  });

  destinationAddress = finalAddress ?? "";

  Constant.storage.write("latitude", point.latitude);
  Constant.storage.write("longitude", point.longitude);

  Constant.storage.write("userAddress", destinationAddress);
  log("User Address :: ${Constant.storage.read("userAddress")}");

  homeScreenController.update([Constant.idGetLocation]);
}
