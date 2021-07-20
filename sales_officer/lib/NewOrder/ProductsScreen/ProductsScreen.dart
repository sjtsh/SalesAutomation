import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_officer/DialogBox/DialogBox.dart';
import 'package:sales_officer/NavBar/ConfirmOrder.dart';
import 'package:sales_officer/NavBar/NavBar.dart';
import 'package:sales_officer/NewOrder/ProductsScreen/ProductList.dart';

import '../../Database.dart';
import '../NewOrder.dart';
import 'SearchBar.dart';
import 'SingularProduct.dart';

class ProductsScreen extends StatefulWidget {
  final Function _setIndex;
  final ScrollController _scrollController = ScrollController();

  ProductsScreen(this._setIndex);

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
    return Column(
      children: [
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => DialogBox(widget._setIndex, 4),
                  );
                },
                child: Text(
                  "Distributor",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.5),
                  size: 12,
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffEA47B2),
                ),
                child: Center(
                    child: Text(
                  currentDistributor.split(" ")[0].substring(0, 1) +
                      currentDistributor.split(" ")[1].substring(0, 1),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                )),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                currentDistributor,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ProductList(
            _setProducts,
            _setNewProducts,
            dropdownValue,
            productList,
            widget._scrollController,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: scrollingDown ? 0 : 74,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, -2))
            ],
          ),
          child: scrollingDown ? Container() : ConfirmOrder(widget._setIndex),
        ),
      ],
    );
  }
}
