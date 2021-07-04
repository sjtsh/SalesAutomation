import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

import '../../Database.dart';
import '../NewOrder.dart';
import 'SearchBar.dart';
import 'SingularProduct.dart';

class ProductsScreen extends StatefulWidget {
  final Function _setIndex;

  ProductsScreen(this._setIndex);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String dropdownValue = "All Products";
  List productList = allProducts;

  void _setNewProducts(String newValue) {
    setState(() {
      dropdownValue = newValue;
      if (newValue == 'All Products') {
        productList = allProducts;
      } else if (newValue == 'New Products') {
        productList = newProducts;
      } else if (newValue == 'Promoted Products') {
        productList = promotedProducts;
      } else if (newValue == 'Trending Products') {
        productList = trendingProducts;
      }
    });
  }

  void _setProducts(List searchedProducts){
    setState(() {
      productList = searchedProducts;
    });
  }

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
              bottom: BorderSide(
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
        SearchBar(_setProducts, _setNewProducts, dropdownValue),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListView(
              children: productList
                  .map(
                    (item) => SingularProduct(item),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
