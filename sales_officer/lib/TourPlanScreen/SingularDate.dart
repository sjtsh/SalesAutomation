import 'package:flutter/material.dart';

import 'Calendar.dart';

class SingularDate extends StatelessWidget {
  final int rowIndex;
  final int index;
  final int startPoint;
  final int current;
  final int startDay;
  final int endDay;
  final Function setStartDay;
  final Function setEndDay;
  final bool isStartCondition;

  SingularDate(
    this.rowIndex,
    this.index,
    this.startPoint,
    this.current,
    this.startDay,
    this.endDay,
    this.setStartDay,
    this.setEndDay,
    this.isStartCondition,
  );

  @override
  Widget build(BuildContext context) {
    int startDayNew = startDay;
    int endDayNew = endDay;
    bool completeDisabled = false;
    bool disabled = false;
    int dateNow = rowIndex + index * 7 + 1 - startPoint;
    if (dateNow > dates[current] || dateNow <= 0) {
      completeDisabled = true;
    }
    if (isStartCondition && dateNow < startDay ||
        !isStartCondition && dateNow < startDay - dates[current - 1]) {
      disabled = true;
    }

    return InkWell(
      onTap: () {
        if (!completeDisabled) {
          if (isStartCondition) {
            setStartDay(dateNow);
          } else {
            if (dateNow + dates[current - 1] - startDay >= 30) {
              setEndDay(dateNow + dates[current - 1]);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Select at least 30 days"),
                duration: Duration(milliseconds: 1000),
              ));
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: completeDisabled || disabled
                  ? Colors.transparent
                  : !isStartCondition &&
                          (dateNow == startDayNew - dates[current - 1])
                      ? Colors.green
                      : isStartCondition && dateNow == startDayNew
                          ? Colors.green
                          : !isStartCondition &&
                                  (dateNow == endDayNew - dates[current - 1])
                              ? Colors.blue
                              : isStartCondition && dateNow == endDayNew
                                  ? Colors.blue
                                  : Colors.transparent),
          child: Center(
            child: Text(
              dateNow <= 0
                  ? (dateNow + dates[current - 1]).toString()
                  : dateNow > dates[current]
                      ? (dateNow - dates[current]).toString()
                      : dateNow.toString(),
              style: TextStyle(
                  color: completeDisabled || disabled
                      ? Colors.black.withOpacity(0.2)
                      : isStartCondition && dateNow == startDayNew ||
                              isStartCondition && dateNow == endDayNew ||
                              !isStartCondition &&
                                  dateNow == (endDayNew - dates[current - 1]) ||
                              !isStartCondition &&
                                  dateNow == (startDayNew - dates[current - 1])
                          ? Colors.white
                          : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
