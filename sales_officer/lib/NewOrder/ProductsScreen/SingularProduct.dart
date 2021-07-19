import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';

import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  final item;
  final ExpandableController _expandableController;
  final List<ExpandableController> _expandableControllers;

  SingularProduct(
    this.item,
    this._expandableController,
    this._expandableControllers,
  );

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: GestureDetector(
        onTap: () {
          print("into the function now");
          if(!_expandableController.expanded){
            for (int i = 0; i < _expandableControllers.length; i++) {
              _expandableControllers[i].expanded = false;
            }
            _expandableController.expanded = true;
          }else{
            _expandableController.expanded = false;
          }
        },
        child: SingularProductHeader(item),
      ),
      expanded: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("into the function now");
              if(!_expandableController.expanded){
                for (int i = 0; i < _expandableControllers.length; i++) {
                  _expandableControllers[i].expanded = false;
                }
                _expandableController.expanded = true;
              }else{
                _expandableController.expanded = false;
              }
            },
            child: SingularProductHeader(item),
          ),
          Column(
            children: productVariations
                .map((item) => SingularProductVariation(item))
                .toList(),
          ),
        ],
      ),
      controller: _expandableController,
    );
  }
}
