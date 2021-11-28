import 'package:flutter/material.dart';

class DidnotEndDay extends StatelessWidget {
  final Function aFunction;

  DidnotEndDay(this.aFunction);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timelapse,
                      size: 80,
                    ),
                    SizedBox(height: 20),
                    Text("You Didnt end day yesterday"),
                  ],
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                aFunction();
              },
              child: Text("Sorry"),
            ),
          ],
        ),
      ),
    );
  }
}
