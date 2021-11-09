import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/DialogBox/ConfirmationModalSheet.dart';

import '../Database.dart';

class IndividualConfirmationVariation extends StatelessWidget {
  final Function updateReceiptData;
  final List f;
  final Function deleteReceiptData;
  final Distributor distributor;

  IndividualConfirmationVariation(
    this.updateReceiptData,
    this.f,
    this.deleteReceiptData,
    this.distributor,
  );

  @override
  Widget build(BuildContext context) {
    SKU sku =SKU(1, "", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1, "", false);
    SKUDistributorWise skuDistributorWise = SKUDistributorWise(1, 1, 1, 1, 1, 1, 1);
    try{  skuDistributorWise =
        allSKUDistributorWiseLocal.firstWhere((element) =>
            element.distributorID == distributor.distributorID &&
            element.SKUID == f[0].SKUID);


       sku =
          allSKULocal.firstWhere((element) => element.SKUID == f[0].SKUID);
    } catch(e){
      throw Exception(" Something Went Wrong");
    }

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmationModalSheet(f, updateReceiptData);
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
                        f[0].SKUName,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Builder(
                        builder: (context) {
                          try {
                            return Text(
                              allBillingCompanysLocal
                                  .firstWhere((element) =>
                              skuDistributorWise.billingCompanyID ==
                                  element.billingCompanyID)
                                  .billingCompanyName,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white),
                            );
                          } catch (e){
                            return Text(
                              "unnamed",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white),
                            );
                          }
                        }
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              f[1] == 0
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          f[1].toString(),
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
              f[1] == 0 || f[2] == 0
                  ? Container()
                  : SizedBox(
                      width: 10,
                    ),
              f[2] == 0
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          f[2].toString(),
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
                  deleteReceiptData(f);
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
