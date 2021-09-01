import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKU.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/SKUDistributorWiseService.dart';
import 'package:sales_officer/BACKEND/Services/SKUService.dart';
import 'package:sales_officer/BACKEND/Services/SubGroupService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmOrder.dart';
import 'package:sales_officer/ProductsScreen/ProductList.dart';
import 'package:sales_officer/Skeletons/ProductListSkeleton.dart';

import '../Database.dart';
import '../Database.dart';
import '../Database.dart';
import '../DistributorList/NewOrder.dart';
import 'SearchBar.dart';

class ProductsScreen extends StatefulWidget {
  final Distributor currentDistributor;
  final int index;
  final DistributorOrder distributorOrder;
  final bool isNew;

  final SubGroupService subGroupService = SubGroupService();

  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  ProductsScreen(
      this.currentDistributor, this.index, this.distributorOrder, this.isNew);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String dropdownValue = "All Products";
  List<SubGroup> productList = [];
  bool scrollingDown = false;
  List<TextEditingController> _textEditingControllers = [];
  bool isSearching = false;
  List<DistributorOrderItem> distributorOrderItems = [];

  void _setNewProducts(String newValue) {
    setState(() {
      dropdownValue = newValue;
      // if (newValue == 'All Products') {
      //   productList = allSubGroupsLocal;
      // } else if (newValue == 'New Products') {
      //   productList = allSubGroupsLocal.sublist(0, 2);
      // } else if (newValue == 'Promoted Products') {
      //   productList = allSubGroupsLocal.sublist(2, 4);
      // } else if (newValue == 'Trending Products') {
      //   productList = allSubGroupsLocal.sublist(4, 6);
      // }
      scrollingDown = false;
    });
  }

  void _setProducts(List<SubGroup> searchedSubGroup) {
    setState(() {
      allSubGroupsLocal = searchedSubGroup;
      if (allSubGroupsLocal.length > 0) {
        isSearching = true;
      } else {
        isSearching = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SKUService skuService = SKUService();
    skuService.fetchSKUs().then(
      (value) {
        allSKULocal = [];
        setState(() {
          allSKULocal = value;
          allSKULocal.sort((a, b) => a.subGroupID.compareTo(b.subGroupID));
        });
        _textEditingControllers =
            List.generate(value.length * 2, (index) => TextEditingController());
      },
    );
    SKUDistributorWiseService skuDistributorWiseService =
        SKUDistributorWiseService();
    skuDistributorWiseService.fetchSKUDistributorWises().then((value) {
      setState(() {
        allSKUDistributorWiseLocal = value;
      });

      if (widget.distributorOrder.distributorID != -1) {
        DistributorOrderItemService distributorOrderItemService =
            DistributorOrderItemService();
        distributorOrderItemService.fetchDistributorOrderItems().then((value) {
          distributorOrderItems = [];
          value.forEach((element) {
            if (element.distributorOrderID ==
                widget.distributorOrder.distributorOrderID) {
              distributorOrderItems.add(element);
            }
          });

          print(distributorOrderItems);

          distributorOrderItems.forEach((element) {
            print(element.SKUID.toString() +
                " " +
                element.alternativeItemCount.toString() +
                " " +
                element.primaryItemCount.toString());
          });

          distributorOrderItems.forEach((element) {
            _textEditingControllers[allSKULocal.indexOf(allSKULocal
                        .firstWhere((aSKU) => element.SKUID == aSKU.SKUID)) *
                    2]
                .text = element.primaryItemCount.toString();
            _textEditingControllers[allSKULocal.indexOf(allSKULocal.firstWhere(
                            (aSKU) => element.SKUID == aSKU.SKUID)) *
                        2 +
                    1]
                .text = element.alternativeItemCount.toString();
          });
        });
      }
    });

    widget._scrollController.addListener(() {
      if (widget._scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!scrollingDown) {
          setState(() {
            scrollingDown = true;
          });
        }
      }
      if (widget._scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollingDown) {
          setState(() {
            scrollingDown = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    widget._scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(widget.index, false),
          Container(
              padding: EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: BreadCrum2(
                  "Distributor", widget.currentDistributor.distributorName)),
          Expanded(
            child: Form(
              key: widget._formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: scrollingDown ? 0 : 80,
                      child: SearchBar(
                          _setProducts, _setNewProducts, dropdownValue),
                    ),
                    Expanded(
                        child: !isSearching
                            ? FutureBuilder(
                                future: widget.subGroupService.fetchSubGroups(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    productList = snapshot.data;
                                    allSubGroupsLocal = snapshot.data;
                                    return ProductList(
                                      productList,
                                      widget._scrollController,
                                      _textEditingControllers,
                                    );
                                  }
                                  return ListView(
                                    children: List.generate(10, (index) => "")
                                        .map((item) => ProductListSkeleton())
                                        .toList(),
                                  );
                                },
                              )
                            : ProductList(
                                allSubGroupsLocal,
                                widget._scrollController,
                                _textEditingControllers)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 3,
                    offset: Offset(0, -2))
              ],
            ),
            child: ConfirmOrder(widget.currentDistributor,
                _textEditingControllers, widget.index, widget.isNew, widget.distributorOrder, distributorOrderItems),
          ),
        ],
      ),
    );
  }
}
