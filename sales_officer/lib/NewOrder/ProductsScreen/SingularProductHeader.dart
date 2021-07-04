import 'package:flutter/material.dart';

class SingularProductHeader extends StatelessWidget {

  final item;

  SingularProductHeader(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ))),
      child: Container(
        height: 80,
        margin: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
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
    );
  }
}
