import 'package:flutter/material.dart';
import 'package:sales_officer/NavBar/NavBar.dart';

class DialogContent extends StatelessWidget {

  final Function _setIndex;
  final int i;

  DialogContent(this._setIndex, this.i);

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
              NavBar.onItemTapped(i);
              _setIndex(i);
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
