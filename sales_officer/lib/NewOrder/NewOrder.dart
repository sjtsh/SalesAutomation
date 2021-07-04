import 'package:flutter/material.dart';
import 'package:sales_officer/NewOrder/ProductsScreen/ProductsScreen.dart';
import 'package:sales_officer/NewOrder/Search.dart';

import '../Database.dart';
import 'DistributorList.dart';

// class DataList {
//   DataList(this.title, [this.children = const <DataList>[]]);
//
//   final String title;
//   final List<DataList> children;
// }

String currentDistributor = "";
List distributorList = [];

class NewOrder extends StatefulWidget {
  final Function _setIndex;

  NewOrder(this._setIndex);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  void setDistributors(List searchedDistributors) {
    setState(() {
      distributorList = searchedDistributors;
    });
  }

  @override
  void initState() {
    distributorList = allDistributors;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  horizontal: BorderSide(color: Color(0xffE8E8E8), width: 1))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      height: 60,
                      width: double.infinity,
                      child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Distributors",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                          onChanged: (_distributor) {
                            searchForDistributor(_distributor, setDistributors);
                          }),
                    ),
                  ),
                  MaterialButton(
                    height: 50,
                    elevation: 0,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {},
                    child: Icon(Icons.search_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: distributorList
                .map((item) => DistributorList(widget._setIndex, item))
                .toList(),
          ),
        ),
      ],
    );
  }
}
