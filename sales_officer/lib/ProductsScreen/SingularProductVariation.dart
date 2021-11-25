import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
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
    SKU sku =
    allSKULocal.firstWhere((element) => element.SKUID == widget.item.SKUID);
    try {
      mySKUStock = allSKUStocksLocal.firstWhere((element) =>
          element.distributorID == widget.currentDistributor.distributorID &&
          element.SKUID == widget.item.SKUID);
    } catch (e) {
      mySKUStock = SKUStock(0, widget.item.SKUID,
          widget.currentDistributor.distributorID, meSOID!, false);
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        color: Color(0xffE8F5E9),
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
                                          "${allUnitsLocal.firstWhere((element) => element.unitID == sku.primaryUnitID).unitName}",
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
                                          "${allUnitsLocal.firstWhere((element) => element.unitID == sku.alternativeUnitID).unitName}",
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextField(
                        controller: widget._textEditingControllerPrimary,
                        cursorWidth: 1,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.blue,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: allUnitsLocal.firstWhere((element) => element.unitID == sku.primaryUnitID).unitName,
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.3)),
                          border: InputBorder.none,
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
                        controller: widget._textEditingControllerSecondary,
                        cursorWidth: 1,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.blue,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: allUnitsLocal.firstWhere((element) => element.unitID == sku.alternativeUnitID).unitName,
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
