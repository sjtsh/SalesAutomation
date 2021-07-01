import 'package:flutter/material.dart';

class NewOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return ExpansionTile();
    // return ExpansionTile(
    //     key: PageStorageKey(this.widget.headerTitle),
    //     title: Container(
    //         width: double.infinity,
    //
    //         child: Text("Header",style: TextStyle(fontSize: 18),),
    //         trailing: Icon(Icons.arrow_drop_down,size: 32,color: Colors.pink,),
    //         onExpansionChanged: (value){
    //           setState(() {
    //             isExpand=value;
    //           });
    //         },
    //         children: [
    //           Text("Child 1",style: TextStyle(fontSize: 18),),
    //           Text("Child 2",style: TextStyle(fontSize: 18),),
    //         ]
    //     )
    // );
  }
}

// ExpansionTile: It is a simple and useful widget. This widget lets you create a collapse or expansion view with features similar to ListTile. It is like a ListTile which will expand on tapping the title.
//
// ExpansionTile has the following attributes similar to List Tile:
//
// Properties: backgroundColor: set the background color to the widget.
//
// children: To add a child widget we will use this property
//
// initiallyExpanded: if we set true, child will expands default
//
// onExpansionChanged: To handle the expansion event

