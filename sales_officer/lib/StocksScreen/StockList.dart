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

  StockList(this.subGroupList,
      this._scrollController,
      this._textEditingControllers,
      this.currentDistributor,
      this.returnOrdersCountList,
      this.updateReturnOrdersCountList);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {

  int currentlyExpanded = 0;

  changeCurrentlyExpanded(int currentlyExpanded) {
    setState(() {
      if (this.currentlyExpanded == currentlyExpanded) {
        this.currentlyExpanded = 0;
      } else {
        this.currentlyExpanded = currentlyExpanded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      controller: widget._scrollController,
      children: widget.subGroupList
          .map(
            (item) =>
            StockSingularProduct(
                item,
                currentlyExpanded,
                changeCurrentlyExpanded,
                widget._textEditingControllers,
                widget.currentDistributor,
                widget.returnOrdersCountList,
                widget.updateReturnOrdersCountList),
      )
          .toList(),
    );
  }
}
