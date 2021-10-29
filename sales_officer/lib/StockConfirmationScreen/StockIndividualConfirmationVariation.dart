import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/DialogBox/ConfirmationModalSheet.dart';
import 'package:sales_officer/DialogBox/StockReturnModal.dart';

import '../Database.dart';

class StockIndividualConfirmationVariation extends StatefulWidget {
  final Function updateReceiptData;
  final List f;
  final Function deleteReceiptData;
  final Distributor distributor;
  final List returnOrdersCountList;
  final List<TextEditingController> textEditingControllers;
  final Function updateReturnOrdersCountList;

  StockIndividualConfirmationVariation(
    this.updateReceiptData,
    this.f,
    this.deleteReceiptData,
    this.distributor,
    this.returnOrdersCountList,
    this.textEditingControllers,
    this.updateReturnOrdersCountList,
  );

  @override
  _StockIndividualConfirmationVariationState createState() =>
      _StockIndividualConfirmationVariationState();
}

class _StockIndividualConfirmationVariationState
    extends State<StockIndividualConfirmationVariation> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List counts;
    try {
      counts = widget.returnOrdersCountList.firstWhere((element) {
        return element[0].SKUID == widget.f[0].SKUID;
      });
    } catch (e) {
      counts = [widget.f[0], 0, 0, 0];
    }

    SKUDistributorWise skuDistributorWise =
        allSKUDistributorWiseLocal.firstWhere((element) =>
            element.distributorID == widget.distributor.distributorID &&
            element.SKUID == widget.f[0].SKUID);
    SKU sku =
    allSKULocal.firstWhere((element) => element.SKUID == widget.f[0].SKUID);
    TextEditingController primaryTextEditingController =
        widget.textEditingControllers[allSKULocal.indexOf(allSKULocal
                .firstWhere((element) => element.SKUID == widget.f[0].SKUID)) *
            2];
    TextEditingController alternativeTextEditingController = widget
        .textEditingControllers[allSKULocal.indexOf(allSKULocal
                .firstWhere((element) => element.SKUID == widget.f[0].SKUID)) *
            2 +
        1];
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmationModalSheet(widget.f, widget.updateReceiptData);
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        widget.f[0].SKUName,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      )),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            allBillingCompanysLocal
                                .firstWhere((element) =>
                                    skuDistributorWise.billingCompanyID ==
                                    element.billingCompanyID)
                                .billingCompanyName,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      counts[1] != 0 || counts[2] != 0
                          ? InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StockReturnModal(
                                        widget.f[0],
                                        primaryTextEditingController,
                                        alternativeTextEditingController,
                                        skuDistributorWise,
                                        widget.returnOrdersCountList,
                                        widget.updateReturnOrdersCountList,
                                        refresh,
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: SvgPicture.asset(
                                          "icons/returnorder.svg",
                                          color: Colors.red,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          counts[1] != 0
                                              ? Text(
                                                  "${counts[1]}${allUnitsLocal.firstWhere((element) => element.unitID == sku.primaryUnitID).unitName}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                )
                                              : Container(),
                                          counts[2] != 0
                                              ? Text(
                                                  " ${counts[2]}${allUnitsLocal.firstWhere((element) => element.unitID == sku.alternativeUnitID).unitName}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
              Expanded(child: Container()),
              widget.f[1] == 0
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          widget.f[1].toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          " ${allUnitsLocal.firstWhere((element) => element.unitID == sku.primaryUnitID).unitName}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
              widget.f[1] == 0 || widget.f[2] == 0
                  ? Container()
                  : SizedBox(
                      width: 10,
                    ),
              widget.f[2] == 0
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          widget.f[2].toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          " ${allUnitsLocal.firstWhere((element) => element.unitID == sku.alternativeUnitID).unitName}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  widget.deleteReceiptData(widget.f);
                },
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
