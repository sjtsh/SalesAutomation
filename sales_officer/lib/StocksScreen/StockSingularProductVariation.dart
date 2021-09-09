import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/Database.dart';

class StockSingularProductVariation extends StatefulWidget {
  final SKU item;
  final TextEditingController _textEditingControllerPrimary;
  final TextEditingController _textEditingControllerSecondary;
  final Distributor currentDistributor;

  StockSingularProductVariation(
    this.item,
    this._textEditingControllerPrimary,
    this._textEditingControllerSecondary,
    this.currentDistributor,
  );

  @override
  _StockSingularProductVariationState createState() =>
      _StockSingularProductVariationState();
}

class _StockSingularProductVariationState
    extends State<StockSingularProductVariation> {
  @override
  Widget build(BuildContext context) {
    SKUStock mySKUStock;
    SKUDistributorWise skuDistributorWise =
        allSKUDistributorWiseLocal.firstWhere((element) =>
            element.distributorID == widget.currentDistributor.distributorID &&
            element.SKUID == widget.item.SKUID);
    try {
      mySKUStock = allSKUStocksLocal!.firstWhere((element) =>
          element.distributorID == widget.currentDistributor.distributorID &&
          element.SKUID == widget.item.SKUID);
      widget._textEditingControllerPrimary.text =
          mySKUStock.primaryStock.toString();
      widget._textEditingControllerSecondary.text =
          mySKUStock.alternativeStock.toString();
    } catch (e) {
      mySKUStock = SKUStock(0, widget.item.SKUID,
          widget.currentDistributor.distributorID, 0, 0, 0, "", 0, 0);
      widget._textEditingControllerPrimary.text =
          mySKUStock.primaryStock.toString();
      widget._textEditingControllerSecondary.text =
          mySKUStock.alternativeStock.toString();
    }
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        color: Color(0xffF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 12,
          ),
          Expanded(
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
                allSKUStocksLocal == null
                    ? Container()
                    : Row(
                        children: [
                          Text(
                            "Stock: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                          mySKUStock.primaryStock == 0
                              ? Container()
                              : Text(
                                  mySKUStock.primaryStock.toString() +
                                      " ${skuDistributorWise.primaryUnit}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                          mySKUStock.primaryStock == 0 ||
                                  mySKUStock.alternativeStock == 0
                              ? Container()
                              : SizedBox(width: 5),
                          mySKUStock.alternativeStock == 0
                              ? Container()
                              : Text(
                                  mySKUStock.alternativeStock.toString() +
                                      " ${skuDistributorWise.alternativeUnit}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                        ],
                      )
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.1)),
            ),
            padding: const EdgeInsets.only(bottom: 5),
            child: TextField(
              controller: widget._textEditingControllerPrimary,
              cursorWidth: 1,
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: skuDistributorWise.primaryUnit,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(bottom: 5),
            child: Center(
              child: TextField(
                controller: widget._textEditingControllerSecondary,
                cursorWidth: 1,
                keyboardType: TextInputType.number,
                cursorColor: Colors.blue,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: skuDistributorWise.alternativeUnit,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
