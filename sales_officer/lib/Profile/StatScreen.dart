import 'package:flutter/material.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  String dropdownValue = 'MTD';

  void _setNewProducts(String newValue) {
    setState(() {
      dropdownValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, bottom: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Progress',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    width: 50,
                    child: DropdownButton<String>(
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      isExpanded: true,
                      value: dropdownValue,
                      underline: Container(),
                      iconSize: 20,
                      iconEnabledColor: Colors.black,
                      elevation: 0,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      onChanged: (newValue) {
                        _setNewProducts(newValue!);
                      },
                      items: <String>[
                        'MTD',
                        'YTD',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Total Sales",
                    style:
                    TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "Rs 500000",
                    style:
                    TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffe8e8e8),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 250),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [Color(0xff5A6FF0), Color(0xffC31FE6)],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    bottom: 2,
                    child: Text(
                      "50,000",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    bottom: 2,
                    child: Text(
                      "Sell 2 Lakhs order to get Rs 1000 bonus",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    "Average SKU",
                    style:
                    TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "80 SKU",
                    style:
                    TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffe8e8e8),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 300),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [
                        Color(0xff129C8D),
                        Color(0xff34E77E),
                      ]),
                    ),
                  ),
                  Positioned(
                    left: 4,
                    bottom: 2,
                    child: Text(
                      "5 SKU",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    bottom: 2,
                    child: Text(
                      "Sell 2 more sku to get Rs 1000 bonus",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}