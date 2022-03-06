import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales_officer/Location/LocationScreen.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';

logIn(context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(minutes: 2),
      //     content: Text('Location permissions are denied'),
      //   ),
      // );
      Navigator.push(context, MaterialPageRoute(builder: (_){
        return LocationScreen();
      }));
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(minutes: 2),
        content: Text('Location permissions are denied'),
      ),
    );
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LogInScreen(),
    ),
  );
}
