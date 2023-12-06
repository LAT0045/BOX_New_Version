import 'dart:async';
import 'package:box/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _center = const LatLng(10.7851111, 106.6908738);
  final Set<Marker> _markers = {};

  String _enteredAddress = '';
  String _selectedAddress = '';

  final LocationService _locationService = LocationService();

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _center,
            infoWindow: const InfoWindow(title: 'Vị trí hiện tại'),
          ),
        );
      });

      _goToLocation(_center);
    } catch (e) {
      print('Không thể lấy vị trí: $e');
    }
  }

  Future<void> _goToLocation(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 15.0,
      ),
    ));
  }

  Future<void> _updateLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location first = locations.first;
        LatLng newLocation = LatLng(first.latitude, first.longitude);

        setState(() {
          _markers.clear();
          _markers.add(
            Marker(
              markerId: const MarkerId('selectedLocation'),
              position: newLocation,
              infoWindow: const InfoWindow(title: 'Vị trí đã chọn'),
            ),
          );
          _selectedAddress = address; 
        });

        _goToLocation(newLocation);
      }
    } catch (e) {
      print('Không thể lấy vị trí từ địa chỉ: $e');
    }
  }

  void _saveAndReturnAddress(String address) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String selectedAddress = _selectedAddress.isNotEmpty ? _selectedAddress : address;
      await prefs.setString('savedAddress', selectedAddress); // Lưu địa chỉ vào SharedPreferences
      Navigator.pop(context, selectedAddress);
    } catch (e) {
      print('Lỗi khi lưu địa chỉ: $e');
    }
  }

  void _updateAddressFromMarker(LatLng tappedPoint) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      tappedPoint.latitude, tappedPoint.longitude);

      Placemark? placemark =_locationService.findPlacemarkWithAllInfo(placemarks);
      

    if (placemarks.isNotEmpty) {
      setState(() {
        // ignore: avoid_print
        print(placemarks[0]);
        _enteredAddress =
            "${placemark?.street}, ${placemark?.subLocality}, ${placemark?.subAdministrativeArea}, ${placemark?.administrativeArea}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((_) {
      _updateAddressFromMarker(_center);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(10, 10),
                  zoom: 5,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (LatLng tappedPoint) {
                  setState(() {
                    _markers.clear();
                    _markers.add(
                      Marker(
                        markerId: const MarkerId('selectedLocation'),
                        position: tappedPoint,
                        infoWindow: const InfoWindow(title: 'Vị trí đã chọn'),
                      ),
                    );
                    _updateAddressFromMarker(tappedPoint); // Update address from marker tap
                  });
                  _goToLocation(tappedPoint);
                },
                markers: _markers,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Bạn đang ở đâu?',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _updateLocationFromAddress(_enteredAddress);
                      },
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white)),
                      
                  ),
                  style: const TextStyle(fontSize: 17, fontFamily: 'Comfortaa'),
                  onChanged: (value) {
                    setState(() {
                      _enteredAddress = value;
                    });
                  },
                  controller: TextEditingController(text: _enteredAddress),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 90,
                  vertical: 40,
                ),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    gradient: const LinearGradient(
                      colors: [AppColors.orangeColor, AppColors.yellowColor],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _saveAndReturnAddress(_enteredAddress);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      "Xác nhận",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}