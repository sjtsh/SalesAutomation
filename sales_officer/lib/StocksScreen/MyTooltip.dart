import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';

class MyTooltip extends StatefulWidget {
  final SKUStock mySKUStock;
  final SKUDistributorWise skuDistributorWise;
  final bool isTooltips;

  MyTooltip(this.mySKUStock, this.skuDistributorWise, this.isTooltips);

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
                          "${widget.skuDistributorWise.primaryUnit}",
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
                          "${widget.skuDistributorWise.alternativeUnit}",
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
