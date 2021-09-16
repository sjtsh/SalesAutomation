import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';

import 'StockSingularProduct.dart';

class StockList extends StatefulWidget {
  final List<SubGroup> subGroupList;
  final ScrollController _scrollController;
  final List<TextEditingController> _textEditingControllers;
  final Distributor currentDistributor;
  final List returnOrdersCountList;
  final Function updateReturnOrdersCountList;

  StockList(
      this.subGroupList,
      this._scrollController,
      this._textEditingControllers,
      this.currentDistributor,
      this.returnOrdersCountList,
      this.updateReturnOrdersCountList);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  List<ExpandableController> _expandableControllers = [];

  @override
  Widget build(BuildContext context) {
    _expandableControllers = List.generate(
        widget.subGroupList.length, (index) => ExpandableController());

    return ListView(
      controller: widget._scrollController,
      children: widget.subGroupList
          .map(
            (item) => StockSingularProduct(
                item,
                widget.subGroupList.indexOf(item),
                _expandableControllers,
                widget._textEditingControllers,
                widget.currentDistributor,
                widget.returnOrdersCountList,
                widget.updateReturnOrdersCountList),
          )
          .toList(),
    );
  }
}
