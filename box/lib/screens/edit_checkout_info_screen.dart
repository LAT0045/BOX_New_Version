import 'dart:async';

import 'package:flutter/material.dart';
import 'package:box/utils/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class EditUserInfoScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String address;

  const EditUserInfoScreen({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.address,
  }) : super(key: key);

  @override
  _EditUserInfoScreenState createState() => _EditUserInfoScreenState();
}

class _EditUserInfoScreenState extends State<EditUserInfoScreen> {
  String newName = '';
  String newPhoneNumber = '';
  String newAddress = '';
  late TextEditingController _addressController;
  GoogleMapController? _mapController;
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};
  LatLng _selectedLocation = LatLng(10, 10);

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.address);
    newName = widget.name;
    newPhoneNumber = widget.phoneNumber;
    newAddress = widget.address;
    _setMarkerAtAddress();
  }

  void _setMarkerAtAddress() async {
    try {
      List<Location> locations = await locationFromAddress(widget.address);
      if (locations.isNotEmpty) {
        Location first = locations.first;
        LatLng addressLocation = LatLng(first.latitude, first.longitude);
        _addMarker(addressLocation);
      }
    } catch (e) {
      print('Không thể lấy vị trí từ địa chỉ: $e');
    }
  }

  void _addMarker(LatLng location) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('defaultLocation'),
          position: location,
          infoWindow: const InfoWindow(title: 'Địa chỉ mặc định'),
        ),
      );
    });

    _moveToLocation(location);
  }

  void _moveToLocation(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(location));
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _addMarker(_selectedLocation);
      });
    } catch (e) {
      print('Không thể lấy vị trí: $e');
    }
  }

  void _updateLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location first = locations.first;
        LatLng newLocation = LatLng(first.latitude, first.longitude);

        setState(() {
          _addMarker(newLocation);
          newAddress = address;
          _selectedLocation = newLocation;
        });
      }
    } catch (e) {
      print('Không thể lấy vị trí từ địa chỉ: $e');
    }
  }

  void _updateAddressFromMarker(LatLng tappedPoint) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        tappedPoint.latitude, tappedPoint.longitude);

    if (placemarks.isNotEmpty) {
      Placemark? placemark = placemarks.first;
      setState(() {
        newAddress =
            "${placemark.street}, ${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}";
        _addressController.text = newAddress;
        _selectedLocation = tappedPoint;
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId('selectedLocation'),
            position: tappedPoint,
            infoWindow: const InfoWindow(title: 'Vị trí đã chọn'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.orangeColor),
        title: const Text(
          'Chỉnh sửa thông tin đặt hàng',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 30, left: 30),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      newName = value;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.orangeColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.orangeColor),
                      ),
                      hintText: 'Tên bạn là gì?',
                    ),
                    cursorColor: AppColors.orangeColor,
                    style:
                        const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
                    controller: TextEditingController(text: widget.name),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      newPhoneNumber = value;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.orangeColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.orangeColor),
                      ),
                      hintText: 'Số điện thoại',
                    ),
                    cursorColor: AppColors.orangeColor,
                    style:
                        const TextStyle(fontSize: 20, fontFamily: 'Comfortaa'),
                    controller: TextEditingController(text: widget.phoneNumber),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 20, right: 20, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Bạn đang ở đâu?',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _updateLocationFromAddress(_addressController.text);
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.only(left: 20, bottom: 5, right: 5),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(fontSize: 17, fontFamily: 'Comfortaa'),
                onChanged: (value) {
                  newAddress = value;
                },
                controller: _addressController,
              ),
            ),
            Container(
              height: 450,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _selectedLocation,
                  zoom: 18,
                ),
                markers: _markers,
                onTap: (LatLng tappedPoint) {
                  _updateAddressFromMarker(tappedPoint);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                  Map<String, String> editedData = {
                    'name': newName,
                    'phoneNumber': newPhoneNumber,
                    'address': newAddress,
                  };
                  Navigator.pop(context, editedData);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 30, right: 30),
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
          ],
        ),
      ),
    );
  }
}
