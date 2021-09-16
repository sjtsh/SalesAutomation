import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/Database.dart';
import 'package:sales_officer/DialogBox/StockReturnModal.dart';


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
      this.updateReturnOrdersCountList);

  @override
  _StockSingularProductVariationState createState() =>
      _StockSingularProductVariationState();
}

class _StockSingularProductVariationState
    extends State<StockSingularProductVariation> {
  refresh() {
    setState(() {});
  }

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
        color: Color(0xffF5F5F5),
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
                    : Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Text(
                                "Stock: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                              widget.mySKUStock.primaryStock == 0
                                  ? Container()
                                  : Text(
                                      widget.mySKUStock.primaryStock
                                              .toString() +
                                          "${skuDistributorWise.primaryUnit}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                              widget.mySKUStock.primaryStock == 0 ||
                                      widget.mySKUStock.alternativeStock == 0
                                  ? Container()
                                  : SizedBox(width: 5),
                              widget.mySKUStock.alternativeStock == 0
                                  ? Container()
                                  : Text(
                                      widget.mySKUStock.alternativeStock
                                              .toString() +
                                          "${skuDistributorWise.alternativeUnit}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                            ],
                          ),
                        ),
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
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          "icons/returnorder.svg",
                          color: Colors.red,
                        ),
                      )),
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
                        hintText: "${skuDistributorWise.primaryUnit}",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.3)),
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
                        hintText: "${skuDistributorWise.alternativeUnit}",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.3)),
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
