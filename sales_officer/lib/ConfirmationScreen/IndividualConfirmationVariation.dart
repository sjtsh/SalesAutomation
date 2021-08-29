import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/DialogBox/ConfirmationModalSheet.dart';

import '../Database.dart';

class IndividualConfirmationVariation extends StatelessWidget {
  final Function updateReceiptData;
  final List f;
  final Function deleteReceiptData;

  IndividualConfirmationVariation(this.updateReceiptData, this.f, this.deleteReceiptData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            Text(
              f[1].toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Text(
              " Pcs",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              f[2].toString(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Text(
              " Pcs",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
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
    );
  }
}
