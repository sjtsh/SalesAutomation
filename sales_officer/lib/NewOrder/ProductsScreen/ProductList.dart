import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'SearchBar.dart';
import 'SingularProduct.dart';

class ProductList extends StatefulWidget {
  final Function _setProducts;
  final Function _setNewProducts;
  final String dropdownValue;
  final List productList;
  final ScrollController _scrollController;

  ProductList(this._setProducts, this._setNewProducts, this.dropdownValue,
      this.productList, this._scrollController);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  var _expandableController;

  @override
  void initState() {
    _expandableController = List.generate(widget.productList.length, (index) => ExpandableController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        controller: widget._scrollController,
        children: [
          SearchBar(widget._setProducts, widget._setNewProducts, widget.dropdownValue),
          Column(
            children: widget.productList
                .map(
                  (item) => SingularProduct(item, _expandableController[widget.productList.indexOf(item)], _expandableController),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
