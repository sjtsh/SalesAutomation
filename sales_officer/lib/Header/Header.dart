import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final int index;

  Header(this.index);

  // if(i==0){
  // message = "STOCKS";
  // }else if(i==1){
  // message = "PENDING";
  // }else if(i==2){
  // message = "PROFILE";
  // }else if(i==3){
  // message = "DISTRIBUTOR";
  // }else if(i==4){
  // message = "NEW ORDER";
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, -2))
        ],
      ),
      child: Row(
        children: [
          MaterialButton(
            onPressed: () {},
            child: Icon(Icons.menu),
          ),
          Text(index==0 ? "STOCKS": index==1 ? "PENDING" : index==2 ? "PROFILE" :index==3?"DISTRIBUTOR":"NEW ORDER"),
          Expanded(
            child: Container(),
          ),
          MaterialButton(
            onPressed: () {},
            child: Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
    );
  }
}
