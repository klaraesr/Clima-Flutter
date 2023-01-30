import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:clima/utilities/api_key.dart';

class WeatherBody {
  Coordinate coord;
  String name;

  WeatherBody(this.coord, this.name);
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    Coordinate userCoordinates;
    try {
      LocationService location = LocationService();
      userCoordinates = await location.getUserLocation();
    } catch (e) {
      print('Could not get user location. Error $e');
    }
    var data = await NetworkHelper(
            'http://api.openweathermap.org/data/2.5/weather?lat=${userCoordinates.latitude}&lon=${userCoordinates.longitude}&appid=$apiKey')
        .getData();
    String description = data['weather'][0]['description'];
    double temp = data['main']['temp'];
    print('It is $description and $temp degrees');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => LocationScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
