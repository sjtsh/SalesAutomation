import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/DialogBox/StockReturnModal.dart';

import 'MyTooltip.dart';

class StockSingularProductVariation extends StatefulWidget {
  final SKU item;
  final List<TextEditingController> _textEditingControllers;
  final Distributor currentDistributor;
  final List returnOrdersCountList;
  final SKUStock mySKUStock;
  final Function updateReturnOrdersCountList;

  StockSingularProductVariation(
    this.item,
    this._textEditingControllers,
    this.currentDistributor,
    this.returnOrdersCountList,
    this.mySKUStock,
    this.updateReturnOrdersCountList,
  );

  @override
  _StockSingularProductVariationState createState() =>
      _StockSingularProductVariationState();
}

class _StockSingularProductVariationState
    extends State<StockSingularProductVariation> {
  refresh() {}

  @override
  Widget build(BuildContext context) {
    SKUDistributorWise skuDistributorWise =
        allSKUDistributorWiseLocal.firstWhere((element) =>
            element.distributorID == widget.currentDistributor.distributorID &&
            element.SKUID == widget.item.SKUID);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        color: Color(0xffE3F2FD),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.SKUName,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                allSKUStocksLocal == null
                    ? Container()
                    : MyTooltip(
                        widget.mySKUStock,
                        skuDistributorWise,
                      ),
                SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return StockReturnModal(
                              widget.item,
                              widget._textEditingControllers[
                                  allSKULocal.indexOf(widget.item) * 2],
                              widget._textEditingControllers[
                                  allSKULocal.indexOf(widget.item) * 2 + 1],
                              skuDistributorWise,
                              widget.returnOrdersCountList,
                              widget.updateReturnOrdersCountList,
                              refresh);
                        });
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Return",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextField(
                        controller: widget._textEditingControllers[
                            allSKULocal.indexOf(widget.item) * 2],
                        cursorWidth: 1,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.blue,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText:
                              "${allUnitsLocal.firstWhere((element) => skuDistributorWise.primaryUnitID == element.unitID).unitName}",
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextField(
                        controller: widget._textEditingControllers[
                            allSKULocal.indexOf(widget.item) * 2 + 1],
                        cursorWidth: 1,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.blue,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText:
                              "${allUnitsLocal.firstWhere((element) => skuDistributorWise.alternativeUnitID == element.unitID).unitName}",
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
