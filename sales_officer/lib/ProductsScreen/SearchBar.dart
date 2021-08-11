import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Search.dart';

class SearchBar extends StatefulWidget {
  final Function _setProducts;
  final Function _setNewProducts;
  final String dropdownValue;

  SearchBar(this._setProducts, this._setNewProducts, this.dropdownValue);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Center(
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: TextField(
                      cursorColor: Colors.black,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Distributors",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                      onChanged: (_products) {
                        searchForProducts(_products, widget._setProducts);
                      }),
                ),
              ),
              Container(
                width: 1,
                height: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 90,
                child: DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                isExpanded: true,
                  value: widget.dropdownValue,
                  underline: Container(),
                  iconSize: 12,
                  elevation: 0,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  onChanged: (newValue) {
                    widget._setNewProducts(newValue);
                  },
                  items: <String>[
                    'All Products',
                    'Promoted Products',
                    'New Products',
                    'Trending Products'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, overflow: TextOverflow.ellipsis,),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
