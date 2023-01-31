import '../utilities/api_key.dart';
import 'location_service.dart';
import 'networking.dart';

const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Coordinate userCoordinates;
    try {
      LocationService location = LocationService();
      userCoordinates = await location.getUserLocation();
    } catch (e) {
      print('Could not get user location. Error $e');
    }
    var data = await NetworkHelper(
            '$openWeatherMapURL?lat=${userCoordinates.latitude}&lon=${userCoordinates.longitude}&appid=$apiKey&units=metric')
        .getData();
    String description = data['weather'][0]['description'];
    double temp = data['main']['temp'];
    print('It is $description and $temp degrees');
    return data;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var data = await NetworkHelper('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric').getData();
    String description = data['weather'][0]['description'];
    double temp = data['main']['temp'];
    print('It is $description and $temp degrees');
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
