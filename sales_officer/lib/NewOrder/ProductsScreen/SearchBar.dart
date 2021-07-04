import 'package:flutter/material.dart';
import 'package:sales_officer/NewOrder/ProductsScreen/FilterProducts.dart';
import 'package:sales_officer/NewOrder/ProductsScreen/SearchProducts.dart';

class SearchBar extends StatefulWidget {
  final Function _setProducts;
  final Function _setNewProducts;
  final String dropdownValue;

  SearchBar(this._setProducts, this._setNewProducts, this.dropdownValue);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool open = false;

  _animateContainer() {
    setState(() {
      open = !open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500,),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: open ? Colors.white : Colors.transparent,
        border: Border.symmetric(
          horizontal: BorderSide(color: Color(0xffE8E8E8), width: 1),
        ),
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: open ? Color(0xffF5F5F5) : Colors.transparent,
          borderRadius:
              open ? BorderRadius.circular(12) : BorderRadius.circular(0),
        ),
        child: open
            ? SearchProducts(widget._setProducts,_animateContainer,)
            : FilterProducts(_animateContainer, widget._setNewProducts, widget.dropdownValue),
      ),
    );
    // open
    //     ? Container(
    //     padding: const EdgeInsets.all(12.0),
    //
    //     child:
    // )
    //     : Container(
    //   padding: EdgeInsets.all(12),
    //   width: double.infinity,
    //   child: Container(
    //     height: 60,
    //     child: SearchProducts(_animateContainer, widget.dropdownValue),
    //   ),
    // );
  }
}
