import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/Database.dart';

import 'SingularProduct.dart';

class ProductList extends StatefulWidget {
  final List<SubGroup> subGroupList;
  final ScrollController _scrollController;
  final List<TextEditingController> _textEditingControllers;

  ProductList(
      this.subGroupList, this._scrollController, this._textEditingControllers);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ExpandableController> _expandableControllers = [];

  @override
  Widget build(BuildContext context) {
    _expandableControllers = List.generate(
        widget.subGroupList.length, (index) => ExpandableController());
    return ListView(
      controller: widget._scrollController,
      children: widget.subGroupList
          .map(
            (item) => SingularProduct(item, widget.subGroupList.indexOf(item),
                _expandableControllers, widget._textEditingControllers),
          )
          .toList(),
    );
  }
}
