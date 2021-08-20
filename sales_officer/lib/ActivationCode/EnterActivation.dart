import 'package:flutter/material.dart';

class EnterActivation extends StatelessWidget {
  const EnterActivation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 5),
      child: Container(alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter activation",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
