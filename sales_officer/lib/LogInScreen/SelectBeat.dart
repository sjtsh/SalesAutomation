import 'package:flutter/material.dart';
import 'package:sales_officer/HomeScreen.dart';

class SelectBeat extends StatefulWidget {
  @override
  _SelectBeatState createState() => _SelectBeatState();
}

class _SelectBeatState extends State<SelectBeat> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        "Dhumbarahi - Sukedhara",
        "Chabahil - Mitrapark",
        "Gopikrishna - Pahelo Pool",
        "Pahelo Pool - Rato Pool",
        "Gopikrishna - Pahelo Pool",
        "Kalo Pool - Rato Pool",
        "Kalo Pool - Rato Pool",
        "Kalo Pool - Rato Pool",
        "Kalo Pool - Rato Pool",
      ]
          .asMap()
          .entries
          .map((e) => GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1)),),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        e.value,
                        style: TextStyle(
                            fontSize: 18,
                            color:Colors.black),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
