import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';

import '../Header.dart';

class GoogleMapPersonal extends StatefulWidget {
  final Distributor currentDistributor;

  GoogleMapPersonal(this.currentDistributor);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<GoogleMapPersonal> {
  refresh() {
    setState(() {});
  }

  var _googleMapController;
  var _origin;
  List<Marker> _restaurants = [];
  Location _location = Location();
  List<LatLng> _locations = [];
  List _locationsName = [];

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  // void _addMarker(LatLng pos){
  //   if(_destination==null) {
  //     setState(() {
  //       _destination = Marker(
  //         markerId: const MarkerId("destination"),
  //         infoWindow: const InfoWindow(title: "Destination"),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //         position: pos,
  //       );
  //       _destination = null;
  //     });
  //   }
  // }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    _location.onLocationChanged.listen((l) {
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  widget.currentDistributor.lat, widget.currentDistributor.lng),
              zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  widget.currentDistributor.lat, widget.currentDistributor.lng),
              zoom: 20,
              tilt: 50.0,
            ),
            myLocationButtonEnabled: true,

            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            // initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            markers: {
              Marker(
                markerId:
                MarkerId(widget.currentDistributor.distributorID.toString()),
                infoWindow: InfoWindow(
                    title: "${widget.currentDistributor.distributorName}: " +
                        widget.currentDistributor.ownerName),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                position: LatLng(
                    widget.currentDistributor.lat, widget.currentDistributor.lng),
              )
            },

            // onLongPress: _addMarker,
            // myLocationEnabled: true,
          ),
          Header(11, false, refresh),
        ],
      ),
    );
  }
}
