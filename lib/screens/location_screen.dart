import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon = '';
  String cityName;
  String weatherDescription = '';

  @override
  void initState() {
    super.initState();
    setWeatherData(widget.locationWeather);
    print('Init location screen ${widget.locationWeather}');
  }

  void setWeatherData(dynamic weatherData) {
    setState(() {
      temperature = weatherData['main']['temp'].toInt();
      int weatherCode = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(weatherCode);
      weatherDescription = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(156, 19, 66, 29),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var data = await weather.getLocationWeather();
                      setWeatherData(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var searchQuery = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (searchQuery != null) {
                        var data = await weather.getCityWeather(searchQuery);
                        setWeatherData(data);
                      } else {
                        var data = await weather.getLocationWeather();
                        setWeatherData(data);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$cityName',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text('$temperature°', style: kTempTextStyle),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherDescription,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
