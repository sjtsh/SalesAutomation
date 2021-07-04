import 'package:flutter/material.dart';

class FilterProducts extends StatelessWidget {
  final Function _animateContainer;
  final dropdownValue;
  final _setNewProducts;

  FilterProducts(this._animateContainer, this._setNewProducts, this.dropdownValue);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          iconSize: 30,
          elevation: 0,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          onChanged: (newValue) {
            _setNewProducts(newValue);
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
        GestureDetector(
          onTap: () {
            print("Tapped");
            _animateContainer();
          },
          child: Icon(Icons.search_outlined, size: 30,),
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
