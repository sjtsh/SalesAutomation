import 'package:flutter/material.dart';

class SingularProductVariation extends StatelessWidget {
  final item;

  SingularProductVariation(this.item);

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
              item,
            ),
          ),
          Container(
            height: 50,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(top: 5),
            child: TextField(
            cursorWidth: 1,
            keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
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
