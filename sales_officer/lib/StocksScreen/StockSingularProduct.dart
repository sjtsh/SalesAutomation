import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/Database.dart';

import 'StockSingularProductHeader.dart';
import 'StockSingularProductVariation.dart';

class StockSingularProduct extends StatefulWidget {
  final SubGroup item;
  final int expandableControllerIndex;
  final List<ExpandableController> _expandableControllers;
  final List<TextEditingController> _textEditingControllers;
  final Distributor currentDistributor;
  final List returnOrdersCountList;
  final Function updateReturnOrdersCountList;

  StockSingularProduct(
      this.item,
      this.expandableControllerIndex,
      this._expandableControllers,
      this._textEditingControllers,
      this.currentDistributor,
      this.returnOrdersCountList,
      this.updateReturnOrdersCountList);

  @override
  _StockSingularProductState createState() => _StockSingularProductState();
}

class _StockSingularProductState extends State<StockSingularProduct> {
  bool isTooltips = false;

  unExpand() {
    if (!widget
        ._expandableControllers[widget.expandableControllerIndex].expanded) {
      for (int i = 0; i < widget._expandableControllers.length; i++) {
        if (i != widget.expandableControllerIndex) {
          widget._expandableControllers[i].expanded = false;
        } else {
          widget._expandableControllers[i].expanded = true;
        }
      }
    } else {
      widget._expandableControllers[widget.expandableControllerIndex].expanded =
          false;
    }
    setState(() {
      isTooltips = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: StockSingularProductHeader(widget.item, unExpand),
      expanded: Column(
        children: [
          StockSingularProductHeader(widget.item, unExpand),
          Column(
            children: allSKULocal
                .where(
                    (element) => element.subGroupID == widget.item.subGroupID)
                .map((item) {
              SKUStock mySKUStock;
              try {
                mySKUStock = allSKUStocksLocal!.firstWhere((element) =>
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
                  isTooltips);
            }).toList(),
          ),
        ],
      ),
      controller:
          widget._expandableControllers[widget.expandableControllerIndex],
    );
  }
}
