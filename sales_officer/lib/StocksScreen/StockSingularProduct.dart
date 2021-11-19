import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';
import 'package:sales_officer/Database.dart';

import 'StockSingularProductHeader.dart';
import 'StockSingularProductVariation.dart';

class StockSingularProduct extends StatefulWidget {
  final SubGroup item;
  final int currentlyExpanded;
  final Function changeCurrentlyExpanded;
  final List<TextEditingController> _textEditingControllers;
  final Distributor currentDistributor;
  final List returnOrdersCountList;
  final Function updateReturnOrdersCountList;

  StockSingularProduct(
      this.item,
      this.currentlyExpanded,
      this.changeCurrentlyExpanded,
      this._textEditingControllers,
      this.currentDistributor,
      this.returnOrdersCountList,
      this.updateReturnOrdersCountList);

  @override
  _StockSingularProductState createState() => _StockSingularProductState();
}

class _StockSingularProductState extends State<StockSingularProduct> {
  ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    if (widget.currentlyExpanded == widget.item.subGroupID) {
      _expandableController.expanded = true;
    } else {
      _expandableController.expanded = false;
    }
    return ExpandablePanel(
      collapsed: StockSingularProductHeader(
          widget.item, widget.changeCurrentlyExpanded, Icons.add),
      expanded: Column(
        children: [
          StockSingularProductHeader(
              widget.item, widget.changeCurrentlyExpanded, Icons.remove),
          Column(
            children: allSKULocal
                .where(
                    (element) => element.subGroupID == widget.item.subGroupID)
                .map((item) {
              SKUStock mySKUStock;
              try {
                mySKUStock = allSKUStocksLocal.firstWhere((element) =>
                    element.distributorID ==
                        widget.currentDistributor.distributorID &&
                    element.SKUID == item.SKUID);
              } catch (e) {
                mySKUStock = SKUStock(0, 0, 0, 0, 0, 0, "", 0, 0, false);
              }
              return StockSingularProductVariation(
                item,
                widget._textEditingControllers,
                widget.currentDistributor,
                widget.returnOrdersCountList,
                mySKUStock,
                widget.updateReturnOrdersCountList,
              );
            }).toList(),
          ),
        ],
      ),
      controller: _expandableController,
    );
  }
}
