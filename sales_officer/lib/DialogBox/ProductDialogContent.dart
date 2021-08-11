import 'package:flutter/material.dart';

class ProductDialogContent extends StatelessWidget {
  final List item;

  ProductDialogContent(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.1),
          ),
          child: Image.asset(
            "products/kurumkurumchiura.png",
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item[0],
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              Text(
                item[1],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Stock: ${item[2]} Pcs",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        RawMaterialButton(
          onPressed: () {},
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
