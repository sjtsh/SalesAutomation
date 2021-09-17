import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'FAQExpandablePanel2.dart';

class FAQExpandablePanel extends StatelessWidget {
  final String e;
  final ExpandableController _expandableControllerMain = ExpandableController();

  FAQExpandablePanel(this.e);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: _expandableControllerMain,
      collapsed: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: Text(e as String)),
                    Icon(Icons.keyboard_arrow_down_sharp)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      expanded: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                _expandableControllerMain.expanded =
                    !_expandableControllerMain.expanded;
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(e as String)),
                            Icon(Icons.keyboard_arrow_up)
                          ],
                        ),
                        SizedBox(height: 12,),
                        Column(
                          children: [
                            "Why is my App stuck in loading screen?",
                            "Why cant I take orders?",
                            "Why is my app glitching?"
                          ]
                              .map(
                                (e) => FAQExpandablePanel2(e),
                          )
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
