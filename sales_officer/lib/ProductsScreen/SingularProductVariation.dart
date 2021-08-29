import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';

class SingularProductVariation extends StatefulWidget {
  final SKU item;
  final TextEditingController _textEditingControllerPrimary;
  final TextEditingController _textEditingControllerSecondary;

  SingularProductVariation(this.item, this._textEditingControllerPrimary, this._textEditingControllerSecondary);

  @override
  _SingularProductVariationState createState() =>
      _SingularProductVariationState();
}

class _SingularProductVariationState extends State<SingularProductVariation> {

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
          SizedBox(
            width: 12,
          ),
          Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.1)),
            ),
            padding: const EdgeInsets.only(bottom: 5),
            child: TextField(
              controller: widget._textEditingControllerPrimary,
              cursorWidth: 1,
              keyboardType: TextInputType.number,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "carton",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(bottom: 5),
            child: Center(
              child: TextField(
                controller: widget._textEditingControllerSecondary,
                cursorWidth: 1,
                keyboardType: TextInputType.number,
                cursorColor: Colors.blue,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "pcs",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
