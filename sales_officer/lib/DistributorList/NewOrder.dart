import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Methods/Search.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorService.dart';
import '../Database.dart';
import 'DistributorList.dart';

class NewOrder extends StatefulWidget {
  final int index;
  final Function refresh;
  final DistributorService distributorService = DistributorService();

  NewOrder(
    this.index,
    this.refresh,
  );

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  bool isSearching = false;
  bool isNotFound = false;

  void setDistributors(List<Distributor> searchedDistributors) {
    setState(() {
      searchedDistributorsLocal = searchedDistributors.where((element) => !element.deactivated).toList();
      if (searchedDistributorsLocal.length > 0) {
        isSearching = true;
        isNotFound = false;
      } else {
        isNotFound = true;
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
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: "Search Distributors",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 16,
                              ),
                            ),
                            onChanged: (_distributor) {
                              if (_distributor != "") {
                                searchForDistributor(
                                    _distributor, setDistributors);
                              } else {
                                setDistributors(personalDistributorsLocal.where((element) => !element.deactivated).toList());
                              }
                            },
                          ),
                        ),
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
        SizedBox(
          height: 6,
        ),
        isNotFound
            ? Expanded(
                child: Center(
                  child: Text("No Search Found."),
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                    child: !isSearching
                      ? Column(
                          children: personalDistributorsLocal.where((element) => !element.deactivated).toList()
                              .map(
                                (item) => DistributorList(
                                  item,
                                  widget.index,
                                  widget.refresh,
                                ),
                              )
                              .toList(),
                        )
                      : Column(
                          children: searchedDistributorsLocal
                              .map(
                                (item) => DistributorList(
                                  item,
                                  widget.index,
                                  widget.refresh,
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
      ],
    );
  }
}
