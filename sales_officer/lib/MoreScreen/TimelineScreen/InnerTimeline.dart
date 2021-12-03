import 'package:flutter/material.dart';

import 'ActivityWidgets.dart';

class InnerTimeline extends StatelessWidget {
  final bool isSizedBox;
  final Widget individualTimeline;

  InnerTimeline(this.isSizedBox, this.individualTimeline);

  @override
  Widget build(BuildContext context) {
    return isSizedBox
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: individualTimeline,
            ),
          )
        : Container(
            height: 50,
          );
  }
}
