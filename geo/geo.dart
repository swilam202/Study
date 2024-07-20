import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomButton(
              'Request permissions',
              () async {
                await requestPermissions();
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'Enable Location',
              () async {
                await enableLocation();
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'get Location',
              () async {
                final position = await getCurrentLocation();
                print(position);
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'last known Location',
              () async {
                Position? position = await getLastKnownPosition();
                print(position);
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'compare Location',
              () async {
                Position? userLocation = await getCurrentLocation();
                if (userLocation != null) {
                  double distance = compareDistance(
                      userLocation, 31.44005079449098, 31.681155806911494);
                  print(distance);
                }
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'get Location Data',
              () async {
                Position? userLocation = await getCurrentLocation();
                if (userLocation != null) {
                  getLocationData(userLocation);
                }
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'get Location by address',
              () async {
                final List<Location> location =
                    await getLocationByAddress("مصر");
                print(location);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(this.text, this.onPressed, {super.key});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

Future<LocationPermission> requestPermissions() async {
  LocationPermission permission = await Geolocator.requestPermission();

  return permission;
}

Future<void> enableLocation() async {
  bool isEnabled = await Geolocator.isLocationServiceEnabled();

  if (!isEnabled) {
    await Geolocator.openLocationSettings();
  }
}

Future<Position?> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  bool isEnabled = await Geolocator.isLocationServiceEnabled();

  if (isEnabled &&
      (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always)) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  } else {
    await enableLocation();
    return null;
  }
}

Future<Position?> getLastKnownPosition() async {
  return await Geolocator.getLastKnownPosition();
}

double compareDistance(
    Position userLocation, double latitude, double longitude) {
  return Geolocator.distanceBetween(
      userLocation.latitude, userLocation.longitude, latitude, longitude);
}

getLocationData(Position position) async {
  final List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  print(placemarks[0].name);

  print(placemarks[0].country);
  print(placemarks[0].isoCountryCode);

  print(placemarks[0].administrativeArea);
  print(placemarks[0].subAdministrativeArea);

  print(placemarks[0].locality);
  print(placemarks[0].subLocality);

  print(placemarks[0].street);
  print(placemarks[0].postalCode);

  print(placemarks[0].thoroughfare);
  print(placemarks[0].subThoroughfare);
}

Future<List<Location>> getLocationByAddress(String address) async {
  List<Location> locations = await locationFromAddress(address);
  return locations;
}
