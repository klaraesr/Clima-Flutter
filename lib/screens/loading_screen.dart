import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
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
    var data = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => LocationScreen(locationWeather: data)),
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
