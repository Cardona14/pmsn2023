import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pmsn2023/routes.dart';
import 'package:pmsn2023/screens/weather_screen.dart';

class HomerWeather extends StatefulWidget {
  const HomerWeather({super.key});

  @override
  State<HomerWeather> createState() => _HomerWeatherState();
}

class _HomerWeatherState extends State<HomerWeather> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getRoutes(),
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final lat = snapshot.data?.latitude.toString() ?? '0';
            final lon = snapshot.data?.longitude.toString() ?? '0';
            return WeatherScreen(
              lat: lat,
              lon: lon,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}