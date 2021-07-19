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
            height: 40,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Icon(Icons.remove),
          ),
          Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(bottom: 5),
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
                hintText: "0",

                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 40,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.7),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
