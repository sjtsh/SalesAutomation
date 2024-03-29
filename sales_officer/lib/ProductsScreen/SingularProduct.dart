import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';
import 'package:sales_officer/Database.dart';

import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatefulWidget {
  final SubGroup item;
  final int currentlyExpanded;
  final Function changeCurrentlyExpanded;
  final List<TextEditingController> _textEditingControllers;
  final Distributor currentDistributor;

  SingularProduct(
      this.item,
      this.currentlyExpanded,
      this.changeCurrentlyExpanded,
      this._textEditingControllers,
      this.currentDistributor);

  @override
  _SingularProductState createState() => _SingularProductState();
}

class _SingularProductState extends State<SingularProduct> {
  ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    if (widget.currentlyExpanded == widget.item.subGroupID) {
      _expandableController.expanded = true;
    } else {
      _expandableController.expanded = false;
    }
    return ExpandablePanel(
      collapsed: SingularProductHeader(
          widget.item, widget.changeCurrentlyExpanded, Icons.add),
      expanded: Column(
        children: [
          SingularProductHeader(
              widget.item, widget.changeCurrentlyExpanded, Icons.remove),
          Builder(builder: (context) {
            return Column(
              children: allSKULocal
                  .where((element) =>
                      element.subGroupID == widget.item.subGroupID &&
                      !element.deactivated)
                  .map((item) => SingularProductVariation(
                      item,
                      widget._textEditingControllers[
                          allSKULocal.indexOf(item) * 2],
                      widget._textEditingControllers[
                          allSKULocal.indexOf(item) * 2 + 1],
                      widget.currentDistributor))
                  .toList(),
            );
          }),
        ],
      ),
      controller: _expandableController,
    );
  }
}
