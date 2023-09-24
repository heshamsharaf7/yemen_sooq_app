import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(p);
  return p;
}
