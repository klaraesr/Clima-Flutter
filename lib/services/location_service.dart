import 'package:clima/screens/loading_screen.dart';
import 'package:geolocator/geolocator.dart';

class Coordinate {
  double latitude, longitude;

  Coordinate(this.latitude, this.longitude);

  Coordinate.fromMap(Map<String, dynamic> map)
      : latitude = map['latitude'],
        longitude = map['longitude'];

  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude};
}

class LocationService {
  Future<Coordinate> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return Coordinate.fromMap(position.toJson());
  }
}
