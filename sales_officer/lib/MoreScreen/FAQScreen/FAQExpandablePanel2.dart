import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class FAQExpandablePanel2 extends StatelessWidget {
  final String e;
  final Function expanded;
  final String currentlyExpanded;
  final ExpandableController _expandableControllerBase = ExpandableController();

  FAQExpandablePanel2(this.e, this.expanded, this.currentlyExpanded);
  @override
  Widget build(BuildContext context) {
    if (currentlyExpanded == e) {
      _expandableControllerBase.expanded = true;
    } else {
      _expandableControllerBase.expanded = false;
    }
    return ExpandablePanel(
      controller: _expandableControllerBase,
      collapsed: Padding(
        padding:
            const EdgeInsets.only(top: 4, bottom: 4),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.1)),
          ),
          child: InkWell(
            onTap: () {
              expanded(e);
              _expandableControllerBase.expanded =
                  !_expandableControllerBase.expanded;
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(child: Text(e)),
                  Icon(Icons.keyboard_arrow_down_sharp)
                ],
              ),
            ),
          ),
        ),
      ),
      expanded: Padding(
        padding:
            const EdgeInsets.only(top: 4, bottom: 4),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.1)),
          ),
          child: InkWell(
            onTap: () {
              expanded(e);
              _expandableControllerBase.expanded =
                  !_expandableControllerBase.expanded;
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(e)),
                      Icon(Icons.keyboard_arrow_down_sharp)
                    ],
                  ),
                  Text(
                    "Hello World Hello new World Lorem Ipsum ! Hello World Hello new World Lorem Ipsum ! Hello World Hello new World Lorem Ipsum ! Hello World Hello new World Lorem Ipsum !",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
