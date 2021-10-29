import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sales_officer/Database.dart';
import 'package:share_plus/share_plus.dart';

shareOrder(DistributorOrder distributorOrder) {
  List<SKUDistributorWise> skuDistributorWises = allSKUDistributorWiseLocal
      .where(
          (element) => element.distributorID == distributorOrder.distributorID)
      .toList();
  double totalValue = 0;
  DistributorOrderItemService distributorOrderItemService =
      DistributorOrderItemService();
  distributorOrderItemService
      .fetchDistributorOrderItems()
      .then((distributorOrderItems) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Text("Distributor Name: "),
                      pw.Text(allDistributorsLocal
                          .firstWhere((element) =>
                              distributorOrder.distributorID ==
                              element.distributorID)
                          .distributorName),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text("Sales Officer: "),
                      pw.Text(meSO!.SOName),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text("Order Taken: "),
                      pw.Text(distributorOrder.dateAndTime),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Container(
                height: 100,
                decoration: pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black))),
                child: pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 250,
                      child: pw.Text(
                        "Product Name",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Unit Price",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(
                      width: 50,
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
                    pw.SizedBox(
                      width: 50,
                      child: pw.Text(
                        "Billing Company",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Column(
                children: distributorOrderItems.map((e) {
                  SKUDistributorWise mySKUDistributorWise = skuDistributorWises
                      .firstWhere((element) => element.SKUID == e.SKUID);
                  SKU sku = allSKULocal
                      .firstWhere((element) => element.SKUID == e.SKUID);
                  double mereTotal = e.primaryItemCount *
                      sku.primaryCF *
                      sku.MRP +
                      e.alternativeItemCount *
                          sku.alternativeCF *
                          sku.MRP;
                  totalValue += mereTotal;
                  return pw.Container(
                      height: 100,
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(color: PdfColors.black)),
                      ),
                      child: pw.Row(children: [
                        pw.SizedBox(
                          width: 250,
                          child: pw.Text(
                              allSKULocal
                                  .firstWhere(
                                      (element) => element.SKUID == e.SKUID)
                                  .SKUName,
                              maxLines: 4),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            "Rs ${sku.MRP}",
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            "Rs ${e.primaryItemCount.toString() + allUnitsLocal.firstWhere((element) => element.unitID == sku.primaryUnitID).unitName + " " + e.alternativeItemCount.toString() + allUnitsLocal.firstWhere((element) => element.unitID == sku.alternativeUnitID).unitName}",
                          ),
                        ),
                        pw.SizedBox(
                          width: 100,
                          child: pw.Text(
                            mereTotal.toString(),
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            allBillingCompanysLocal
                                .firstWhere((element) =>
                                    element.billingCompanyID ==
                                    mySKUDistributorWise.billingCompanyID)
                                .billingCompanyName,
                          ),
                        ),
                      ]));
                }).toList(),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Row(
                children: [
                  pw.SizedBox(
                      width: 400, child: pw.Center(child: pw.Text("Total"))),
                  pw.SizedBox(width: 100, child: pw.Text("Rs $totalValue"))
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Text("Distributor Qty: "),
                      pw.Text(allDistributorsLocal
                          .firstWhere((element) =>
                              distributorOrder.distributorID ==
                              element.distributorID)
                          .distributorName),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text("Distributor Order Value: "),
                      pw.Text(meSO!.SOName),
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Text("Distributor Net Order Value: "),
                      pw.Text(distributorOrder.dateAndTime),
                    ],
                  ),
                ],
              ),
              pw.Divider(thickness: 1),
            ],
          );
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
