import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/ProductLine.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/Database.dart';

class ConfirmationModalSheet extends StatelessWidget {
  final List f;
  final Function updateReceiptData;
  final TextEditingController _textEditingControllerPrimary =
      TextEditingController();
  final TextEditingController _textEditingControllerAlternative =
      TextEditingController();

  ConfirmationModalSheet(this.f, this.updateReceiptData);

  @override
  Widget build(BuildContext context) {
    SubGroup subGroup = allSubGroupsLocal.firstWhere((element) {
      if( element.subGroupID == f[0].subGroupID){
        return true;
      }
      return false;
    });

    String hintableText1 = f[1].toString();
    String hintableText2 = f[2].toString();
    ProductLine productLine = allProductLinesLocal.firstWhere((element) => element.productLineID == subGroup.productLineID);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Center(
              child: Container(
                height: 300,
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width - 100,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                subGroup.subGroupName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 1),
                                  child: Text(
                                    productLine.productLineName.substring(0, 1) +
                                        productLine.productLineName.substring(
                                            productLine.productLineName.length - 1,
                                            productLine.productLineName.length),
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            // subGroup.subGroupName,
                            f[0].SKUName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Stock: 100 Pcs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container()),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1)),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextField(
                                  controller: _textEditingControllerPrimary,
                                  cursorWidth: 1,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.blue,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  onTap: () {},
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: hintableText1,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextField(
                                  controller: _textEditingControllerAlternative,
                                  cursorWidth: 1,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.blue,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  onTap: () {},
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: hintableText2,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    int primaryCountNew =
                                        _textEditingControllerPrimary.text == ""
                                            ? f[1]
                                            : int.parse(
                                                _textEditingControllerPrimary
                                                    .text);
                                    int alternativeCountNew =
                                        _textEditingControllerAlternative
                                                    .text ==
                                                ""
                                            ? f[2]
                                            : int.parse(
                                                _textEditingControllerAlternative
                                                    .text);
                                    updateReceiptData(f, primaryCountNew,
                                        alternativeCountNew);
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
