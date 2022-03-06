import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/MoreScreen/Settings/Settings.dart';

class LocationScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xffF5F5F5),
            body: Column(
              children: [
                Expanded(child: Container()),
                SvgPicture.asset(
                  "icons/entypo_location.svg",
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Allow your location",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "We will need your location to give you better experience.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                SizedBox(
                  height: 50,
                ),
                // SignInCodeButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff60D74D),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                      },
                      child: Center(
                        child: Text(
                          "Sure, I'd like that",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ));
    }
  }
