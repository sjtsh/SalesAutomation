import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Services/DistributorService.dart';
import 'package:sales_officer/BACKEND/Methods/Search.dart';

import '../Database.dart';
import 'DistributorList.dart';

class NewOrder extends StatefulWidget {
  final bool isOrder;
  final int index;
  final bool isStock;

  final DistributorService distributorService = DistributorService();

  NewOrder(this.isOrder, this.isStock, this.index);

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  bool isSearching = false;
  bool isNoDistributorFound = false;

  void setDistributors(List<Distributor> searchedDistributors) {
    setState(() {
      searchedDistributorsLocal = searchedDistributors;
      if (searchedDistributorsLocal.length > 0) {
        isSearching = true;
        isNoDistributorFound = false;
      } else {
        isNoDistributorFound = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
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
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              height: 35,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(5),
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
                          if (_distributor != "") {
                            searchForDistributor(_distributor, setDistributors);
                          } else {
                            setDistributors(allDistributorsLocal);
                          }
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
        isNoDistributorFound
            ? Expanded(
              child: Center(
                  child: Text(
                    "No Distributor Found",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            )
            : Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: !isSearching
                        ? Column(
                            children: allDistributorsLocal
                                .map(
                                  (item) => DistributorList(
                                      item,
                                      widget.isOrder,
                                      widget.isStock,
                                      widget.index),
                                )
                                .toList(),
                          )
                        : Column(
                            children: searchedDistributorsLocal
                                .map(
                                  (item) => DistributorList(
                                      item,
                                      widget.isOrder,
                                      widget.isStock,
                                      widget.index),
                                )
                                .toList(),
                          ),
                  ),
                ),
              ),
      ],
    );
  }
}
