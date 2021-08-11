import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_officer/BreadCrum/BreadCrum.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/ConfirmationScreen/ConfirmOrder.dart';
import 'package:sales_officer/ProductsScreen/ProductList.dart';

import '../Database.dart';
import '../DistributorList/NewOrder.dart';
import 'SearchBar.dart';

class ProductsScreen extends StatefulWidget {
  final String currentDistributor;
  final int index;
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  ProductsScreen(this.currentDistributor, this.index);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String dropdownValue = "All Products";
  List productList = allProducts;
  bool scrollingDown = false;

  void _setNewProducts(String newValue) {
    setState(() {
      dropdownValue = newValue;
      if (newValue == 'All Products') {
        productList = allProducts;
      } else if (newValue == 'New Products') {
        productList = newProducts;
      } else if (newValue == 'Promoted Products') {
        productList = promotedProducts;
      } else if (newValue == 'Trending Products') {
        productList = trendingProducts;
      }
      scrollingDown = false;
    });
  }

  void _setProducts(List searchedProducts) {
    setState(() {
      productList = searchedProducts;
    });
  }

  @override
  void initState() {
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
    // TODO: implement initState
    super.initState();
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
              child: BreadCrum2("Distributor", widget.currentDistributor)),
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
                      duration: Duration(milliseconds: 500),
                      height: scrollingDown ? 0 : 80,
                      child: scrollingDown
                          ? Container()
                          : SearchBar(
                          _setProducts, _setNewProducts, dropdownValue),),
                    Expanded(
                      child: ProductList(
                        productList,
                        widget._scrollController,
                      ),
                    ),
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
            ),
          ),
        ],
      ),
    );
  }
}
