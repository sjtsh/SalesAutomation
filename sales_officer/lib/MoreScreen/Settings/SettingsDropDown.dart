import 'package:flutter/material.dart';

class SettingsDropDown extends StatefulWidget {
  const SettingsDropDown({Key? key}) : super(key: key);

  @override
  State<SettingsDropDown> createState() => _SettingsDropDownState();
}

class _SettingsDropDownState extends State<SettingsDropDown> {
  String _value = "yes";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: DropdownButton(
        onChanged: (value) {
          setState(() {
            _value = value.toString();
          });
        },
        value: _value,
        underline: Container(),
        items: [
          DropdownMenuItem(
            child: Text("yes"),
            value: "yes",
          ),
          DropdownMenuItem(
            child: Text("no"),
            value: "no",
          )
        ],
      ),
    );
  }
}
