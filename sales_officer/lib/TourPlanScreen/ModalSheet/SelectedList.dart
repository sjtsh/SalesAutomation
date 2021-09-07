import 'package:flutter/material.dart';

import '../../Database.dart';

class SelectedList extends StatelessWidget {
  final String activity;
  final Function setDetail;
  final int index;
  final Function setIsModalFalse;
  final TextEditingController _textEditingController = TextEditingController();
  final Function setTourPlan;
  final String dateTime;

  SelectedList(
    this.dateTime,
    this.activity,
    this.setDetail,
    this.index,
    this.setIsModalFalse,
    this.setTourPlan,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF5F5F5),
        child: activity == "Retailing"
            ? ListView(
                children: beats
                    .map(
                      (option) => Material(
                        child: InkWell(
                          onTap: () {
                            setDetail(option);
                            setIsModalFalse();
                            setTourPlan([dateTime, activity, option], index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black.withOpacity(0.1)))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                option,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          maxLines: 20,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter the Explanation here"),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MaterialButton(
                          color: Colors.yellow,
                          onPressed: () {
                            setDetail(_textEditingController.text);
                            setIsModalFalse();
                            setTourPlan([dateTime, activity, _textEditingController.text], index);
                          },
                          child: Center(
                            child: Text(
                              "SEND",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
