import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'SingularProduct.dart';

class ProductList extends StatefulWidget {
  final List productList;
  final ScrollController _scrollController;

  ProductList(
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
    return ListView(
      controller: widget._scrollController,
      children: widget.productList
              .map(
                (item) => SingularProduct(item, _expandableController[widget.productList.indexOf(item)], _expandableController),
              )
              .toList(),

    );
  }
}
