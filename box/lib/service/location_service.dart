import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  Placemark? findPlacemarkWithAllInfo(List<Placemark> placemarks) {
    try {
      return placemarks.firstWhere((placemark) {
        return placemark.street != null &&
            placemark.subLocality != null &&
            placemark.subAdministrativeArea != null &&
            placemark.administrativeArea != null;
      });
    } catch (e) {
      return placemarks.isNotEmpty ? placemarks[0] : null;
    }
  }

  Future<String> getAddressFromCoordinates(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return "";
    }

    Placemark? placemark = findPlacemarkWithAllInfo(placemarks);

    String address =
        "${placemark?.street}, ${placemark?.subLocality}, ${placemark?.subAdministrativeArea}, ${placemark?.administrativeArea}";

    return address;
  }

  Future<double> calculateDistanceBetweenAddresses(String address1, String address2) async {
  try {
    List<Location> locations1 = await locationFromAddress(address1);
    List<Location> locations2 = await locationFromAddress(address2);

    if (locations1.isNotEmpty && locations2.isNotEmpty) {
      double latitude1 = locations1.first.latitude;
      double longitude1 = locations1.first.longitude;

      double latitude2 = locations2.first.latitude;
      double longitude2 = locations2.first.longitude;

      double distanceInMeters = await Geolocator.distanceBetween(
        latitude1,
        longitude1,
        latitude2,
        longitude2,
      );
      
      double distanceInKm = distanceInMeters / 1000; // Chuyển đổi từ mét sang kilômét
      return distanceInKm;
    } else {
      print('Could not find locations for the addresses.');
      return 0;
    }
  } catch (e) {
    print('Error calculating distance: $e');
    return 0;
  }
}

}