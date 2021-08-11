import 'package:flutter/material.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

class DialogContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child:Container()),
        Text(
          "Are you sure you want to cancel?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16,),
        ),
        Expanded(child:Container()),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            color: Colors.blueGrey,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            color: Colors.green,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Expanded(child:Container()),
      ],
    );
  }
}
