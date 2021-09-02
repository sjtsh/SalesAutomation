import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Services/DistributorService.dart';
import 'package:sales_officer/BACKEND/Methods/Search.dart';

import '../Database.dart';
import 'DistributorList.dart';

class NewOrder extends StatefulWidget {
  final bool isOrder;
  final int index;

  final DistributorService distributorService = DistributorService();

  NewOrder(this.isOrder, this.index);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  bool isSearching = false;

  void setDistributors(List<Distributor> searchedDistributors) {
    setState(() {
      searchedDistributorsLocal = searchedDistributors;
      if (searchedDistributorsLocal.length > 0) {
        isSearching = true;
      } else {
        isSearching = false;
      }
    });
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
                          isCollapsed: true,
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
                  GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.search_outlined),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: !isSearching
              ? ListView(
                  children: allDistributorsLocal
                      .map(
                        (item) =>
                            DistributorList(item, widget.isOrder, widget.index),
                      )
                      .toList(),
                )
              : ListView(
                  children: searchedDistributorsLocal
                      .map(
                        (item) =>
                            DistributorList(item, widget.isOrder, widget.index),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }
}
