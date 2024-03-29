import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKU.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/DialogBox/DiscardPrompt.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/StockConfirmationScreen/StockConfirmOrder.dart';

import '../Database.dart';
import 'SearchBar.dart';
import 'StockList.dart';

List<SKUStock> ourSKUStock = [];

class StocksScreen extends StatefulWidget {
  final Distributor currentDistributor;
  final int index;
  final DistributorOrder distributorOrder;
  final SKUStockService skuStockService = SKUStockService();
  final ScrollController _scrollController = ScrollController();

  final Function refresh;

  final _formKey = GlobalKey<FormState>();

  StocksScreen(
    this.currentDistributor,
    this.index,
    this.distributorOrder,
    this.refresh,
  );

  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  String dropdownValue = "All Products";
  List<SubGroup> productList = [];
  bool scrollingDown = false;
  List<TextEditingController> _textEditingControllers = [];
  List returnOrdersCountList = [];
  bool isSearching = false;
  bool isProductNotFound = false;

  List<DistributorOrderItem> distributorOrderItems = [];

  void _setNewProducts(String newValue) {
    setState(() {
      dropdownValue = newValue;
      scrollingDown = false;
    });
  }

  void _setProducts(List<SubGroup> searchedSubGroup) {
    setState(() {
      productList = searchedSubGroup;
      if (productList.length > 0) {
        isSearching = true;
        isProductNotFound = false;
      } else {
        isProductNotFound = true;
      }
    });
  }

  updateReturnOrdersCountList(
      SKU sku, int primaryCountNew, int alternativeCountNew, String reason) {
    bool isConsists = false;
    returnOrdersCountList.forEach((element) {
      if (element[0].SKUID == sku.SKUID) {
        isConsists = true;
        element[1] = primaryCountNew;
        element[2] = alternativeCountNew;
        element[3] = reason;
      }
    });
    if (!isConsists) {
      returnOrdersCountList
          .add([sku, primaryCountNew, alternativeCountNew, reason]);
    }
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
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            showDialog(
                context: context,
                builder: (_) {
                  return DiscardPrompt();
                });
            return true;
          },
          child: Column(
            children: [
              Header(8, false, widget.refresh),
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
                  "Distributor",
                  widget.currentDistributor.distributorName,
                ),
              ),
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
                        isProductNotFound
                            ? Expanded(
                                child: Center(
                                  child: Text("No Search Found."),
                                ),
                              )
                            : Expanded(
                                child: !isSearching
                                    ? StockList(
                                        allSubGroupsLocal,
                                        widget._scrollController,
                                        _textEditingControllers,
                                        widget.currentDistributor,
                                        returnOrdersCountList,
                                        updateReturnOrdersCountList)
                                    : StockList(
                                        productList,
                                        widget._scrollController,
                                        _textEditingControllers,
                                        widget.currentDistributor,
                                        returnOrdersCountList,
                                        updateReturnOrdersCountList)),
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
                    returnOrdersCountList,
                    updateReturnOrdersCountList,
                    widget.refresh),
              ),
            ],
          ),
        ),
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
    widget.skuStockService.fetchSKUStocks().then((value) {
      setState(() {
        allSKUStocksLocal = value;
      });
      ourSKUStock = allSKUStocksLocal
          .where((element) =>
              element.distributorID == widget.currentDistributor.distributorID)
          .toList();
      allSKULocal.forEach((item) {
        SKUStock mySKUStock;
        try {
          mySKUStock =
              ourSKUStock.firstWhere((element) => element.SKUID == item.SKUID);

          //here________________________________________________
          mySKUStock.primaryStock == 0
              ? _textEditingControllers[allSKULocal.indexOf(item) * 2].text = ""
              : _textEditingControllers[allSKULocal.indexOf(item) * 2].text =
                  mySKUStock.primaryStock.toString();

          mySKUStock.alternativeStock == 0
              ? _textEditingControllers[allSKULocal.indexOf(item) * 2 + 1]
                  .text = ""
              : _textEditingControllers[allSKULocal.indexOf(item) * 2 + 1]
                  .text = mySKUStock.alternativeStock.toString();
          //here________________________________________________
        } catch (e) {}
      });
    });
  }
}
