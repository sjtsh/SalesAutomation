import 'package:flutter/material.dart';

class EnterActivation extends StatelessWidget {
  final Function setTyped;

  EnterActivation(this.setTyped);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 5),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextField(
            onChanged: (input){
              if(input.length==5){
                setTyped(true);
              }else{
                setTyped(false);
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
              hintText: "Enter activation",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14,
              ),
              icon: Icon(
                Icons.radio_button_checked,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
