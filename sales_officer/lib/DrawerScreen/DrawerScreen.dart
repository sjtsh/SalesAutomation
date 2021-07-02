import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
    children: [
    DrawerHeader(child: SvgPicture.asset("icons/logo.svg"))
    ],
    ),
    );
  }
}
