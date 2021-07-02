import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

import 'NewOrder.dart';

class ProductsScreen extends StatefulWidget {
  final Function _setIndex;

  ProductsScreen(this._setIndex);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String dropdownValue = "All Products";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 12),
          alignment: Alignment.centerLeft,
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogBox(widget._setIndex, 4),
                );
                },
                child: Text(
                  "Distributor",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.5),
                  size: 16,
                ),
              ),
              Text(
                currentDistributor,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                iconSize: 24,
                elevation: 0,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'All Products',
                  'Promoted Products',
                  'New Products',
                  'Trending Products'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(Icons.search_outlined),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ListView(

            ),
          ),
        ),
      ],
    );
  }
}
