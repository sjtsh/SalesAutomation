import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/method.dart';

class TasksList extends StatelessWidget {
  final String e;
  final Function tap;
  final int onTapped;
  final int currentlyTapped;

  TasksList(this.e, this.tap, this.onTapped, this.currentlyTapped);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: InkWell(
        onTap: () {
          tap(currentlyTapped);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightGreenAccent,
                ),
                child: Center(
                  child: Text(
                    getInitials(e),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${e}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Expanded(child: Container()),
            Stack(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: onTapped == currentlyTapped
                            ? Colors.red
                            : Colors.transparent),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
