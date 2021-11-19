import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrder.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/DistributorOrderItem.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/SubGroup.dart';
import 'package:sales_officer/BACKEND%20Access/Services/DistributorOrderItemService.dart';
import 'package:sales_officer/BACKEND%20Access/Services/SKUStockService.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/DialogBox/DiscardPrompt.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmOrder.dart';
import 'package:sales_officer/ProductsScreen/ProductList.dart';

import '../Database.dart';
import 'SearchBar.dart';

class ProductsScreen extends StatefulWidget {
  final Distributor currentDistributor;
  final int index;
  final DistributorOrder distributorOrder;
  final bool isNew;
  final Function refresh;

  final SKUStockService skuStockService = SKUStockService();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  ProductsScreen(this.currentDistributor, this.index, this.distributorOrder,
      this.isNew, this.refresh);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  GlobalKey<NavigatorState> _key = GlobalKey();
  String dropdownValue = "All";
  List<SubGroup> productList = [];
  bool scrollingDown = false;
  List<TextEditingController> _textEditingControllers = [];
  bool isSearching = false;
  bool isNotFound = false;
  bool isFiltered = false;
  List<DistributorOrderItem> distributorOrderItems = [];

  void _setNewProducts(String newValue) {
    productList = [];
    setState(() {
      isFiltered = true;
      dropdownValue = newValue;
      if (newValue == 'All') {
        productList = allSubGroupsLocal;
      } else if (newValue == 'New') {
        allSubGroupsLocal.forEach((element) {
          if (allFamiliaritysLocal
              .firstWhere((e) => e.subGroupID == element.subGroupID)
              .isNew) {
            productList.add(element);
          }
        });
      } else if (newValue == 'Promoted') {
        allSubGroupsLocal.forEach((element) {
          if (allFamiliaritysLocal
              .firstWhere((e) => e.subGroupID == element.subGroupID)
              .isPromoted) {
            productList.add(element);
          }
        });
      } else if (newValue == 'Trending') {
        allSubGroupsLocal.forEach((element) {
          if (allFamiliaritysLocal
              .firstWhere((e) => e.subGroupID == element.subGroupID)
              .isTrending) {
            productList.add(element);
          }
        });
      }
      scrollingDown = false;
    });
  }

  void _setProducts(List<SubGroup> searchedSubGroup) {
    setState(() {
      productList = searchedSubGroup;
      if (productList.length > 0) {
        isSearching = true;
        isNotFound = false;
      } else {
        isNotFound = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingControllers = List.generate(
        allSKULocal.length * 2, (index) => TextEditingController());
    if (!widget.isNew) {
      _editOrder(_textEditingControllers);
    }
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

            showDialog(context: context, builder: (_){
              return DiscardPrompt();
            });
            return true;
          },
          child: Column(
            children: [
              Header(widget.isNew ? 7 : 6, false, widget.refresh),
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
                        isNotFound
                            ? Expanded(
                                child: Center(
                                  child: Text("No Search Found."),
                                ),
                              )
                            : Expanded(
                                child: !isSearching && !isFiltered
                                    ? FutureBuilder(
                                        future: widget.skuStockService
                                            .fetchSKUStocks(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<List<SKUStock>>
                                                snapshot) {
                                          allSKUStocksLocal = snapshot.data!;
                                          return ProductList(
                                            allSubGroupsLocal,
                                            widget._scrollController,
                                            _textEditingControllers,
                                            widget.currentDistributor,
                                          );
                                        },
                                      )
                                    : ProductList(
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
                child: ConfirmOrder(
                  widget.currentDistributor,
                  _textEditingControllers,
                  widget.index,
                  widget.isNew,
                  widget.distributorOrder,
                  distributorOrderItems,
                  widget.refresh,
                ),
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
    DistributorOrderItemService distributorOrderItemService =
        DistributorOrderItemService();
    distributorOrderItemService
        .fetchDistributorOrderItems(context)
        .then((value) {
      List<DistributorOrderItem> newDistributorOrderItems = [];

      value.forEach((element) {
        if (element.distributorOrderID ==
            widget.distributorOrder.distributorOrderID) {
          newDistributorOrderItems.add(element);
        }
      });

      newDistributorOrderItems.forEach((element) {
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

      setState(() {
        distributorOrderItems = newDistributorOrderItems;
      });
    });
  }
}
