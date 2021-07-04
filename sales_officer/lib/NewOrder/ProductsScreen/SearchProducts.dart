import 'package:flutter/material.dart';
import 'package:sales_officer/NewOrder/Search.dart';

class SearchProducts extends StatelessWidget {
  final Function _animateContainer;
  final Function _setProducts;

  SearchProducts(this._setProducts, this._animateContainer);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: TextField(
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
                  searchForProducts(_products, _setProducts);
                }),
          ),
        ),
        GestureDetector(
          onTap: () {
            _animateContainer();
          },
          child: Icon(Icons.filter_alt_outlined),
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
