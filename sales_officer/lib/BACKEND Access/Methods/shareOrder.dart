import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/Database.dart';
import 'package:share_plus/share_plus.dart';

shareOrder(
  DistributorOrder distributorOrder, context
) {
  double totalValue = 0;
  double companyValue = 0;
  int companyPrimaryUnit = 0;
  int totalPrimaryUnit = 0;
  int totalAlternativeUnit = 0;
  int companyAlternativeUnit = 0;
  DistributorOrderItemService distributorOrderItemService =
      DistributorOrderItemService();
  distributorOrderItemService
      .fetchDistributorOrderItems(context)
      .then((allDistributorOrderItems) async {
    List<DistributorOrderItem> distributorOrderItems = allDistributorOrderItems
        .where((element) =>
            element.distributorOrderID == distributorOrder.distributorOrderID)
        .toList();
    Map<int, List<DistributorOrderItem>> distributorOrderItemCompany = {};
    distributorOrderItems.forEach((element) {
      SKUDistributorWise aSKU = SKUDistributorWise(1, 1, 1, 10, 1, 1, 10);
      try{
         aSKU = allSKUDistributorWiseLocal.firstWhere(
            (skuDistributorWise) =>
                element.SKUID == skuDistributorWise.SKUID &&
                skuDistributorWise.distributorID ==
                    distributorOrder.distributorID);
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NO DISTRIBUTOR ID FOUND")));

      }
      // allBillingCompanysLocal.firstWhere((element) => aSKU.defaultBillingCompanyID == element.billingCompanyID)
      if (distributorOrderItemCompany.containsKey(aSKU.billingCompanyID)) {
        distributorOrderItemCompany[aSKU.billingCompanyID]?.add(element);
      } else {
        distributorOrderItemCompany.addAll(
          {
            aSKU.billingCompanyID: [element],
          },
        );
      }
    });
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context context) {
          return pw.Padding(
              padding: pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text(
                            "Sales Officer Name: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            meSO!.SOName,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Company Name: Hilife Foods Nepal",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Distributor Name: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            personalDistributorsLocal
                                .firstWhere((element) =>
                                    distributorOrder.distributorID ==
                                    element.distributorID)
                                .distributorName,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Date: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            distributorOrder.dateAndTime,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Phone: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            meSO!.phone.toString(),
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Order Taken: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            distributorOrder.dateAndTime,
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Status: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            distributorOrder.orderStatus
                                ? "Approved"
                                : "Pending",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Column(
                    children: distributorOrderItemCompany.entries.map(
                      (company) {
                        companyValue = 0;
                        companyPrimaryUnit = 0;
                        companyAlternativeUnit = 0;
                        int count = 0;
                        return pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.symmetric(
                              horizontal: pw.BorderSide(
                                  color: PdfColors.black, width: 1),
                            ),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                  height: 50,
                                  width: 600,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColors.black, width: 1),
                                    ),
                                  ),
                                  child: pw.Align(
                                    alignment: pw.Alignment.centerLeft,
                                    child: pw.Text(
                                      allBillingCompanysLocal
                                          .firstWhere((element) =>
                                              company.key ==
                                              element.billingCompanyID)
                                          .billingCompanyName,
                                      style: pw.TextStyle(fontSize: 25),
                                    ),
                                  )),
                              pw.SizedBox(height: 6),
                              pw.Row(
                                children: [
                                  pw.SizedBox(
                                    width: 50,
                                    child: pw.Text(
                                      "SN",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 200,
                                    child: pw.Text(
                                      "Product Name",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 50,
                                  ),
                                  pw.SizedBox(
                                    width: 100,
                                    child: pw.Text(
                                      "Unit Price",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 100,
                                    child: pw.Text(
                                      "Qty",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 100,
                                    child: pw.Text(
                                      "Value",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              pw.Column(
                                children: company.value.map((e) {
                                  SKU sku = SKU(1, "", 1, 1, 1, 1, 1, 1, 1, 1, 1, "", 1, "", false);

                                 try {
                                   sku = allSKULocal.firstWhere(
                                        (element) => element.SKUID == e.SKUID);
                                  }catch(e){


                                 }
                                  double mereTotal = e.primaryItemCount *
                                      sku.primaryCF *
                                      sku.MRP +
                                      e.alternativeItemCount *
                                          sku.alternativeCF *
                                          sku.MRP;
                                  totalValue += mereTotal;
                                  companyValue += mereTotal;

                                  totalPrimaryUnit += e.primaryItemCount;
                                  companyPrimaryUnit += e.primaryItemCount;
                                  totalAlternativeUnit +=
                                      e.alternativeItemCount;
                                  companyAlternativeUnit +=
                                      e.alternativeItemCount;
                                  count++;
                                  return pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                        bottom: pw.BorderSide(
                                            color: PdfColors.grey900, width: 1),
                                      ),
                                    ),
                                    child: pw.Padding(
                                      padding:
                                          pw.EdgeInsets.symmetric(vertical: 20),
                                      child: pw.Row(
                                        children: [
                                          pw.SizedBox(
                                            width: 50,
                                            child: pw.Text(
                                              count.toString(),
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 230,
                                            child: pw.Text(
                                                allSKULocal
                                                    .firstWhere((element) =>
                                                        element.SKUID ==
                                                        e.SKUID)
                                                    .SKUName,
                                                maxLines: 4),
                                          ),
                                          pw.SizedBox(
                                            width: 20,
                                          ),
                                          pw.SizedBox(
                                            width: 100,
                                            child: pw.Text(
                                              "Rs ${sku.MRP}",
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 100,
                                            child: pw.Text(
                                              "${e.primaryItemCount.toString() + allUnitsLocal.firstWhere((element) => element.unitID == sku.primaryUnitID).unitName + " " + e.alternativeItemCount.toString() + allUnitsLocal.firstWhere((element) => element.unitID == sku.alternativeUnitID).unitName}",
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 100,
                                            child: pw.Text(
                                              mereTotal.toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              pw.Container(
                                  padding:
                                      pw.EdgeInsets.symmetric(vertical: 12),
                                  child: pw.Align(
                                    alignment: pw.Alignment.centerRight,
                                    child: pw.Row(
                                      children: [
                                        pw.SizedBox(
                                          width: 300,
                                        ),
                                        pw.SizedBox(
                                          width: 100,
                                          child: pw.Center(
                                            child: pw.Text(
                                              "Total",
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 100,
                                          child: pw.Text(
                                            "${companyPrimaryUnit.toString() + " Primary" + " " + companyAlternativeUnit.toString() + " Secondary"}",
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 100,
                                          child: pw.Text(
                                            "Rs $companyValue",
                                            style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text(
                            "Total Qty: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            "${totalPrimaryUnit.toString() + " Primary" + " " + totalAlternativeUnit.toString() + " Secondary"}",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 6,
                      ),
                      pw.Row(
                        children: [
                          pw.Text(
                            "Order Value: ",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text(
                            "Rs $totalValue",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Divider(thickness: 1),
                ],
              ));
        },
      ),
    );
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/HilifeOrder.pdf");

    await file.writeAsBytes(await pdf.save());
    Share.shareFiles([file.path],
        text:
            "Distributor Order Number: #OR${distributorOrder.distributorOrderID}");
  });
}
