import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BACKEND/Methods/Search.dart';
import '../Database.dart';

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
      height: 50,
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
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(5),
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
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: "Search Products",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 16,
                        ),
                      ),
                      onChanged: (_products) {
                        if(_products != ""){
                          searchForProducts(_products, widget._setProducts);
                        }
                        else{
                          widget._setProducts(allSubGroupsLocal);
                        }
                      }),
                ),
              ),
              Container(
                width: 10,
                decoration: BoxDecoration(
                  color: Color(0xffe8e8e8),
                  border:Border(left: BorderSide(color: Colors.black.withOpacity(0.1)))
                ),
              ),
              Container(
                color: Color(0xffe8e8e8),
                width: 140,
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
                      child: Text(
                        value,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: 10,
                color: Color(0xffe8e8e8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
