import 'package:flutter/material.dart';
import 'package:sales_officer/Notification/NotificationsList.dart';

class IndividualNotification extends StatefulWidget {
  final String message;
  final Function setSeen;
  final bool _isSeen;

  IndividualNotification(this.message, this.setSeen, this._isSeen);

  @override
  _IndividualNotificationState createState() => _IndividualNotificationState();
}

class _IndividualNotificationState extends State<IndividualNotification> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.setSeen(messages.indexOf(widget.message));
      },
      child: Container(
        padding: EdgeInsets.only(left: 12),
        alignment: Alignment.centerLeft,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget._isSeen ? Colors.white : Color(0xffe2e2e2),
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
                widget.message,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
