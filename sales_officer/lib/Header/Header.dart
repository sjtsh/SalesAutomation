import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
    bottom: 0,

      height: 100,
      child: Container(
        width: double.infinity,
        color: Colors.blue,
      ),
    );
  }
}
