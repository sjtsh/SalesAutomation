import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';

class SingularProductVariation extends StatefulWidget {
  final SKU item;
  final TextEditingController _textEditingController;

  SingularProductVariation(this.item, this._textEditingController);

  @override
  _SingularProductVariationState createState() =>
      _SingularProductVariationState();
}

class _SingularProductVariationState extends State<SingularProductVariation> {
  String hintableText = "0";
  bool disable = false;
  bool disableSub = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        color: Color(0xffF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              widget.item.SKUName,
            ),
          ),
          GestureDetector(
            onTap: () {
              try {
                if (int.parse(widget._textEditingController.text) > 1) {
                  widget._textEditingController.text =
                      (int.parse(widget._textEditingController.text) - 1)
                          .toString();
                } else if (int.parse(widget._textEditingController.text) == 1) {
                  widget._textEditingController.text =
                      (int.parse(widget._textEditingController.text) - 1)
                          .toString();
                  setState(() {
                    disableSub = true;
                  });
                }
              } catch (e) {
                widget._textEditingController.text = 0.toString();
                setState(() {
                  disableSub = true;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                // color: () {
                //   try {
                //     if (disableSub) {
                //       return Colors.blueGrey;
                //     } else {
                //       return Colors.red.withOpacity(0.7);
                //     }
                //   } catch (e) {
                //     return Colors.red.withOpacity(0.7);
                //   }
                // }(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                cursorWidth: 0,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Cartons",
                  contentPadding: EdgeInsets.only(left: 8),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              try {
                if (int.parse(widget._textEditingController.text) > 1) {
                  widget._textEditingController.text =
                      (int.parse(widget._textEditingController.text) - 1)
                          .toString();
                } else if (int.parse(widget._textEditingController.text) == 1) {
                  widget._textEditingController.text =
                      (int.parse(widget._textEditingController.text) - 1)
                          .toString();
                  setState(() {
                    disableSub = true;
                  });
                }
              } catch (e) {
                widget._textEditingController.text = 0.toString();
                setState(() {
                  disableSub = true;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                // color: () {
                //   try {
                //     if (disableSub) {
                //       return Colors.blueGrey;
                //     } else {
                //       return Colors.red.withOpacity(0.7);
                //     }
                //   } catch (e) {
                //     return Colors.red.withOpacity(0.7);
                //   }
                // }(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                cursorWidth: 0,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Pieces",
                  contentPadding: EdgeInsets.only(left: 12),
                ),
              ),
            ),
          ),
          // Container(
          //   height: 40,
          //   width: 70,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //   ),
          //   padding: const EdgeInsets.only(bottom: 5),
          //   child: TextField(
          //     controller: widget._textEditingController,
          //     cursorWidth: 0,
          //     keyboardType: TextInputType.number,
          //     cursorColor: Colors.black,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 14,
          //     ),
          //     onTap: () {
          //       setState(() {
          //         hintableText = "";
          //       });
          //     },
          //     onChanged: (String i) {
          //       try {
          //         if (int.parse(i) < 1) {
          //           setState(() {
          //             disableSub = true;
          //             disable = false;
          //           });
          //         } else if (int.parse(i) < 5) {
          //           setState(() {
          //             disable = false;
          //             disableSub = false;
          //           });
          //         } else {
          //           setState(() {
          //             disable = true;
          //             disableSub = false;
          //           });
          //         }
          //       } catch (e) {
          //         setState(() {
          //           disable = false;
          //         });
          //       }
          //     },
          //     textAlign: TextAlign.center,
          //     decoration: InputDecoration(
          //       hintText: hintableText,
          //       border: InputBorder.none,
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     if (!disable) {
          //       try {
          //         if (int.parse(widget._textEditingController.text) < 4) {
          //           widget._textEditingController.text =
          //               (int.parse(widget._textEditingController.text) + 1).toString();
          //           setState(() {
          //             disableSub = false;
          //           });
          //         } else if (int.parse(widget._textEditingController.text) == 4) {
          //           widget._textEditingController.text =
          //               (int.parse(widget._textEditingController.text) + 1).toString();
          //           setState(() {
          //             disableSub = false;
          //           });
          //         }
          //       } catch (e) {
          //         widget._textEditingController.text = 1.toString();
          //         setState(() {
          //           disableSub = false;
          //         });
          //       }
          //     }
          //   },
          //   child: Container(
          //     height: 40,
          //     width: 35,
          //     decoration: BoxDecoration(
          //       color: () {
          //         try {
          //           if (int.parse(widget._textEditingController.text) < 5) {
          //             return Colors.green.withOpacity(0.7);
          //           } else {
          //             return Colors.blueGrey;
          //           }
          //         } catch (e) {
          //           return Colors.green.withOpacity(0.7);
          //         }
          //       }(),
          //       borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(12),
          //         bottomRight: Radius.circular(12),
          //       ),
          //     ),
          //     child: Icon(
          //       Icons.add,
          //       color: () {
          //         try {
          //           if (int.parse(widget._textEditingController.text) < 5) {
          //             return Colors.black;
          //           } else {
          //             return Colors.white;
          //           }
          //         } catch (e) {
          //           return Colors.black;
          //         }
          //       }(),
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
