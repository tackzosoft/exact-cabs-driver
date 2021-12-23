import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ShowLocationScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  ShowLocationScreen(this.latitude,this.longitude);

  @override
  _ShowLocationScreenState createState() => _ShowLocationScreenState();
}

class _ShowLocationScreenState extends State<ShowLocationScreen> {

  Set<Marker> _markers = {};
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _googleMapController;
  LocationData location;


  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.latitude.toString() + "----" + widget.longitude.toString());
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 15
      ),
    );
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/logos/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData)  {
        if (_googleMapController != null) {
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void _onMapCreated(GoogleMapController _controller) async{

    Uint8List imageData = await getMarker();

    _googleMapController = _controller;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("id-1"),
        position: LatLng(widget.latitude, widget.longitude),
      ));

      // _markers.add(Marker(
      //   markerId: MarkerId("id-2"),
      //   position: LatLng(widget.latitude + 0.005, widget.longitude),
      //     rotation: 270,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData)
      // ));
      //
      // _markers.add(Marker(
      //   markerId: MarkerId("id-3"),
      //   position: LatLng(widget.latitude , widget.longitude + 0.005),
      //     rotation: 180,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData)
      // ));
      //
      //
      // _markers.add(Marker(
      //   markerId: MarkerId("id-4"),
      //   position: LatLng(widget.latitude + 0.002, widget.longitude - 0.003),
      //     rotation: 45,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData)
      // ));
      //
      // _markers.add(Marker(
      //   markerId: MarkerId("id-5"),
      //   position: LatLng(widget.latitude - 0.003, widget.longitude + 0.003),
      //     rotation: 135,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData)
      // ));
      //
      // _markers.add(Marker(
      //   markerId: MarkerId("id-6"),
      //   position: LatLng(widget.latitude - 0.006, widget.longitude - 0.003),
      //     rotation: 20,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData)
      // ));

    });
  }

}