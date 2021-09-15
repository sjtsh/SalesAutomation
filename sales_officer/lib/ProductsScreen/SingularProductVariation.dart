import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/Database.dart';

class SingularProductVariation extends StatefulWidget {
  final SKU item;
  final TextEditingController _textEditingControllerPrimary;
  final TextEditingController _textEditingControllerSecondary;
  final Distributor currentDistributor;

  SingularProductVariation(
    this.item,
    this._textEditingControllerPrimary,
    this._textEditingControllerSecondary,
    this.currentDistributor,
  );

  @override
  _SingularProductVariationState createState() =>
      _SingularProductVariationState();
}

class _SingularProductVariationState extends State<SingularProductVariation> {
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
    } catch (e) {
      mySKUStock = SKUStock(0, widget.item.SKUID,
          widget.currentDistributor.distributorID, 0, 0, 0, "", 0, 0);
    }
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
                              mySKUStock.primaryStock == 0
                                  ? Container()
                                  : Text(
                                      mySKUStock.primaryStock.toString() +
                                          "${skuDistributorWise.primaryUnit}",
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
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                        border: InputBorder.none,
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
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
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
