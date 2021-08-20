import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  bool _isSeen = false;

  void setSeen() {
    setState(() {
      _isSeen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setSeen();
          },
          child: Container(
            padding: EdgeInsets.only(left: 12),
            alignment: Alignment.centerLeft,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _isSeen ?  Colors.white : Color(0xffe2e2e2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "Mount Everest pinned you.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
