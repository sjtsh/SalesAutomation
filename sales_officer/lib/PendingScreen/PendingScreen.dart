import 'package:flutter/material.dart';

import 'SingularPending.dart';

class PendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
      ),
      child: ListView(
        children: [
          ["Bihani Suppliers", 1356, 50000, true],
          ["DS Suppliers", 1357, 40000, false],
          ["NS Suppliers", 1358, 30000, true],
          ["Sharma Trading", 1359, 20000, false],
          ["Bajracharya Suppliers", 1360, 10000, true],
          ["Bihani Suppliers", 1356, 50000, false],
          ["DS Suppliers", 1357, 40000, false],
          ["NS Suppliers", 1358, 30000, true],
          ["Sharma Trading", 1359, 20000, false],
          ["Bajracharya Suppliers", 1360, 10000, true],
        ]
            .map(
              (e) => SingularPending(e),
        )
            .toList(),
      ),
    );
  }
}
