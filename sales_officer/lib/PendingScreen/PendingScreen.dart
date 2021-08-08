import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../Database.dart';
import 'SingularPending.dart';

List headers = ["Pending Orders","Approved Orders"];

class PendingScreen extends StatefulWidget {

  ScrollController _scrollController = ScrollController();
  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            headers[index],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
            ),
            child: NotificationListener(
              onNotification: (t){
                if (t is ScrollEndNotification) {
                  if(widget._scrollController.position.pixels>130*forPending.where((element) => element[4]).length){
                    setState(() {
                      index = 1;
                    });
                  }else{
                    setState(() {
                      index = 0;
                    });
                  }
                  print(widget._scrollController.position.pixels);
                }
                return false;
              },
              child: ListView(
                controller: widget._scrollController,
                children: [
                  Column(
                    children: forPending
                        .where((element) => element[4])
                        .map(
                          (e) => SingularPending(e),
                        )
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Approved Orders ",
                      style: TextStyle(backgroundColor: Color(0xffF5F5F5)),
                    ),
                  ),
                  Column(
                    children: forPending
                        .where((element) => !element[4])
                        .map(
                          (e) => SingularPending(e),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
