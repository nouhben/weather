import 'package:geolocator/geolocator.dart';

class Location {
  double _longitude;
  double _latitude;

  double get longitude => _longitude;
  double get latitude => _latitude;

  //Location({this.latitude, this.longitude});
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      this._longitude = position.longitude;
      this._latitude = position.latitude;
    } catch (e) {
      print(e);
      this._latitude = 0.0;
      this._longitude = 0.0;
    }
  }
}
