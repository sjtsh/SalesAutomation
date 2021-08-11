import 'package:flutter/material.dart';
import 'package:sales_officer/DialogBox/ProductDialogBox.dart';

class SingularProductHeader extends StatelessWidget {
  final List item;
  final Function unExpand;

  SingularProductHeader(this.item, this.unExpand);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: Container(
        height: 52,
        margin: EdgeInsets.all(12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return ProductDialogBox(item);
                  },
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: Image.asset(
                      "products/kurumkurumchiura.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
            Expanded(
              child: RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  unExpand();
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
