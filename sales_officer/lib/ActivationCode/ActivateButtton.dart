import 'package:flutter/material.dart';
import 'package:sales_officer/LogInScreen/LogInScreen.dart';

class ActivateButton extends StatelessWidget {
  final bool _isTyped;

  ActivateButton(this._isTyped);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 5),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isTyped ? Colors.red : Colors.black.withOpacity(0.1),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInScreen(),
                ));
          },
          child: Center(
            child: Text(
              "Activate",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
