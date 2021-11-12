import 'package:flutter/material.dart';

import '../../Database.dart';

class DataDetails extends StatelessWidget {
  final List item;
  DataDetails(this.item);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        allSKULocal.firstWhere((element) => item[0] == element.SKUID).SKUName.substring(0,20),
      ),
    );
  }
}
