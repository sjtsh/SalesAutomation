import 'package:flutter/material.dart';

class Construction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Under Construction",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
          ),
          MaterialButton(
            color: Colors.white.withOpacity(0.5),
            height: 70,
            onPressed: () {},
            child: Text("BACK", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
