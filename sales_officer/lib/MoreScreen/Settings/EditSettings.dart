import 'package:flutter/material.dart';

class EditSettings extends StatelessWidget {
  final e;

  EditSettings(this.e);

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
        children: e.value
            .map(
              (f) => Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: e.key != e.value.length - 1
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
                      e.key == 0
                          ? TextField(
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
                            )
                          : DropdownButton(
                              value: "yes",
                              items: [
                                DropdownMenuItem(child: Text("yes")),
                                DropdownMenuItem(child: Text("no"))
                              ],
                            ),
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
