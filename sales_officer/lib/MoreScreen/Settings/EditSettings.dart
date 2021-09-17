import 'package:flutter/material.dart';
import 'package:sales_officer/MoreScreen/Settings/SettingsDropDown.dart';

class EditSettings extends StatefulWidget {
  final List e;

  EditSettings(this.e);

  @override
  State<EditSettings> createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 2))
        ],
      ),
      child: Column(
        children: widget.e
            .map(
              (f) => Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: widget.e.indexOf(f) != widget.e.length - 1
                                ? Colors.black.withOpacity(0.1)
                                : Colors.transparent))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Icon(
                              f[0] as IconData,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    f[1] as String,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.e.length > 3
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextField(
                                  cursorWidth: 1,
                                  keyboardType: f[1] == "Phone Number: "
                                      ? TextInputType.phone
                                      : f[1] == "PAN: " ||
                                              f[1] == "Bank Account Number: "
                                          ? TextInputType.number
                                          : f[1] == "Email: "
                                              ? TextInputType.emailAddress
                                              : TextInputType.text,
                                  cursorColor: Colors.blue,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: f[2].toString(),
                                  ),
                                ),
                              ),
                            )
                          : SettingsDropDown()
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
