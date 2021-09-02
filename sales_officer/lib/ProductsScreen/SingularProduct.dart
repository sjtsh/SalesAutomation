import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/Database.dart';

import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  final SubGroup item;
  final int expandableControllerIndex;
  final List<ExpandableController> _expandableControllers;
  final List<TextEditingController> _textEditingControllers;
  final Distributor currentDistributor;

  SingularProduct(this.item, this.expandableControllerIndex,
      this._expandableControllers, this._textEditingControllers, this.currentDistributor);

  unExpand() {
    if (!_expandableControllers[expandableControllerIndex].expanded) {
      for (int i = 0; i < _expandableControllers.length; i++) {
        if (i != expandableControllerIndex) {
          _expandableControllers[i].expanded = false;
        } else {
          _expandableControllers[i].expanded = true;
        }
      }
    } else {
      _expandableControllers[expandableControllerIndex].expanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: SingularProductHeader(item, unExpand),
      expanded: Column(
        children: [
          SingularProductHeader(item, unExpand),
          Column(
            children: allSKULocal
                .where((element) => element.subGroupID == item.subGroupID)
                .map((item) => SingularProductVariation(
                    item,
                    _textEditingControllers[allSKULocal.indexOf(item) * 2],
                    _textEditingControllers[allSKULocal.indexOf(item) * 2 + 1], currentDistributor))
                .toList(),
          ),
        ],
      ),
      controller: _expandableControllers[expandableControllerIndex],
    );
  }
}
