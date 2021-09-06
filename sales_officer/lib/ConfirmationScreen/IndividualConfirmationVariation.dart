import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/DialogBox/ConfirmationModalSheet.dart';

import '../Database.dart';

class IndividualConfirmationVariation extends StatelessWidget {
  final Function updateReceiptData;
  final List f;
  final Function deleteReceiptData;
  final Distributor distributor;

  IndividualConfirmationVariation(
      this.updateReceiptData, this.f, this.deleteReceiptData, this.distributor,);

  @override
  Widget build(BuildContext context) {
    SKUDistributorWise skuDistributorWise =
        allSKUDistributorWiseLocal.firstWhere((element) =>
            element.distributorID == distributor.distributorID &&
            element.SKUID == f[0].SKUID);
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
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    f[0].SKUName,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )),
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
                          " ${skuDistributorWise.primaryUnit}",
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
                          " ${skuDistributorWise.alternativeUnit}",
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
