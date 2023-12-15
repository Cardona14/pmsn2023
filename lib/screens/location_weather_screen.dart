import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/weather_database.dart';
import 'package:pmsn2023/widgets/location_card_widget.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  WeatherDataBase weatherDB = WeatherDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Lugares"),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagWeather,
        builder: (context, value, _) {
          return FutureBuilder(
            future: weatherDB.GETALLLOCATIONS(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return locationCardWidget(
                      snapshot.data![index], context);
                  });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          );
        }
      ),
    );
  }
}