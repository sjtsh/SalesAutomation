import 'package:flutter/material.dart';
import 'package:sales_officer/Search.dart';

import '../Database.dart';
import 'DistributorList.dart';


class NewOrder extends StatefulWidget {
  final Function _setIndex;
  final bool isOrder;
  final int index;

  NewOrder(this._setIndex, this.isOrder, this.index);

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
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      height: 50,
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
                        },
                      ),
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
                .map(
                  (item) => DistributorList(
                      item, widget.isOrder, widget.index),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
