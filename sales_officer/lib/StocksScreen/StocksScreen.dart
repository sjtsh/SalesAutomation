import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND/Services/SKUStockService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/StockConfirmationScreen/StockConfirmOrder.dart';

import '../Database.dart';
import 'SearchBar.dart';
import 'StockList.dart';

List<DistributorOrderItem> distributorOrderItems = [];

class StocksScreen extends StatefulWidget {
  final Distributor currentDistributor;
  final int index;
  final DistributorOrder distributorOrder;
  final SKUStockService skuStockService = SKUStockService();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  StocksScreen(
    this.currentDistributor,
    this.index,
    this.distributorOrder,
  );

  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  String dropdownValue = "All Products";
  List<SubGroup> productList = [];
  bool scrollingDown = false;
  List<TextEditingController> _textEditingControllers = [];
  bool isSearching = false;

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
      productList = searchedSubGroup;
      if (productList.length > 0) {
        isSearching = true;
      } else {
        isSearching = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingControllers = List.generate(
        allSKULocal.length * 2, (index) => TextEditingController());
    _editOrder(_textEditingControllers);
    _addScrollListeners();
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
                      height: scrollingDown ? 0 : 50,
                      child: SearchBar(
                          _setProducts, _setNewProducts, dropdownValue),
                    ),
                    Expanded(
                        child: !isSearching
                            ? FutureBuilder(
                                future: widget.skuStockService.fetchSKUStocks(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<SKUStock>> snapshot) {
                                  allSKUStocksLocal = snapshot.data;
                                  return StockList(
                                    allSubGroupsLocal,
                                    widget._scrollController,
                                    _textEditingControllers,
                                    widget.currentDistributor,
                                  );
                                },
                              )
                            : StockList(
                                productList,
                                widget._scrollController,
                                _textEditingControllers,
                                widget.currentDistributor,
                              )),
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
            child: StockConfirmOrder(
              widget.currentDistributor,
              _textEditingControllers,
              widget.index,
              widget.distributorOrder,
              distributorOrderItems,
            ),
          ),
        ],
      ),
    );
  }

  _addScrollListeners() {
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

  _editOrder(List<TextEditingController> _textEditingControllers) {
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

      distributorOrderItems.forEach((element) {
        _textEditingControllers[allSKULocal.indexOf(allSKULocal
                    .firstWhere((aSKU) => element.SKUID == aSKU.SKUID)) *
                2]
            .text = element.primaryItemCount.toString();
        _textEditingControllers[allSKULocal.indexOf(allSKULocal
                        .firstWhere((aSKU) => element.SKUID == aSKU.SKUID)) *
                    2 +
                1]
            .text = element.alternativeItemCount.toString();
      });
    });
  }
}
