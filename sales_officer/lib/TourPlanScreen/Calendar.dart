import 'package:flutter/material.dart';
import 'package:sales_officer/TourPlanScreen/SingularDate.dart';

final List<int> dates = [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30];
final int startDate1 = 3;

class Calendar extends StatelessWidget {
  final int current;
  final int startDay;
  final int endDay;
  final Function setStartDay;
  final Function setEndDay;
  final bool isStartCondition;

  Calendar(this.current, this.startDay, this.endDay, this.setStartDay,
      this.setEndDay, this.isStartCondition);

  @override
  Widget build(BuildContext context) {
    int startPoint = startDate1;
    for (int i = 0; i < current; i++) {
      startPoint += dates[i];
      startPoint = startPoint % 7;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                .map((e) => Expanded(
                        child: Center(
                            child: Text(
                      e,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))))
                .toList(),
          ),
          Expanded(
            child: Column(
              children: List.generate(
                  (dates[current] + startPoint) ~/ 7 + 1,
                  (index) => Expanded(
                        child: Row(
                          children: List.generate(
                            7,
                            (rowIndex) => Expanded(
                              child: SingularDate(
                                rowIndex,
                                index,
                                startPoint,
                                current,
                                startDay,
                                endDay,
                                setStartDay,
                                setEndDay,
                                isStartCondition,
                              ),
                            ),
                          ),
                        ),
                        //
                      )),
            ),
          )
        ],
      ),
    );
  }
}
