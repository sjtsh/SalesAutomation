import 'package:flutter/material.dart';

import '../../Database.dart';

class ActivityList extends StatelessWidget {
  final Function setIsActivitySelected;

  ActivityList(this.setIsActivitySelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF5F5F5),
      child: ListView(
        children: options
            .map(
              (option) => Material(
                child: InkWell(
                  onTap: () {
                    setIsActivitySelected(option[0]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black.withOpacity(0.1)))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: option[1] ? Colors.green : Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            option[0],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
