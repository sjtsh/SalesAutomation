import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';
import '../Database.dart';

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
                    allProductGroupsLocal.firstWhere((element) => subGroup.productGroupID == element.productGroupID).productGroupName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 5,
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
        Container(
          clipBehavior: Clip.hardEdge,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                "CLOSE",
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
