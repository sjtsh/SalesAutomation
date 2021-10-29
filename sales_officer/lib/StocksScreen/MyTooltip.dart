

import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';

import '../Database.dart';

class MyTooltip extends StatefulWidget {
  final SKUStock mySKUStock;
  final SKU sku;

  MyTooltip(
    this.mySKUStock,
    this.sku,
  );

  @override
  State<MyTooltip> createState() => _MyTooltipState();
}

class _MyTooltipState extends State<MyTooltip> {
  GlobalKey _toolTipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Tooltip(
          message: "Last updated: ${widget.mySKUStock.updatedDate}",
          key: _toolTipKey,
          triggerMode: TooltipTriggerMode.tap,
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 6,
              ),
              Builder(builder: (context) {
                return Text(
                  "Stock: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                );
              }),
              widget.mySKUStock.primaryStock == 0
                  ? Container()
                  : Text(
                      widget.mySKUStock.primaryStock.toString() +
                          "${allUnitsLocal.firstWhere((element) => element.unitID == widget.sku.primaryUnitID).unitName}",
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
                      widget.mySKUStock.alternativeStock.toString() +
                          "${allUnitsLocal.firstWhere((element) => element.unitID == widget.sku.alternativeUnitID).unitName}",
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
    );
  }
}
