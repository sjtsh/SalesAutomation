import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';

class ProductDialogContent extends StatelessWidget {
  final SubGroup subGroup;

  ProductDialogContent(this.subGroup);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subGroup.productGroupName,
                    textAlign: TextAlign.left,
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
                        subGroup.productLineName.substring(0, 1) +
                            subGroup.productLineName.substring(
                                subGroup.productLineName.length - 1,
                                subGroup.productLineName.length),
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
                subGroup.subGroupName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Stock: 100 Pcs",
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
