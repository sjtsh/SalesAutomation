import 'package:flutter/material.dart';

class HeaderProductVariationPage extends StatelessWidget {

  final int index;

  HeaderProductVariationPage(this.index);

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
              offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(Icons.menu),
          ),
          Text(index==0 ? "Stocks": index==1 ? "Pending" : index==2 ? "Profile" :index==3?"Distributor":"New Order"),
          Expanded(
            child: Container(),
          ),
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            child: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.green,),
          ),
        ],
      ),
    );
  }
}
