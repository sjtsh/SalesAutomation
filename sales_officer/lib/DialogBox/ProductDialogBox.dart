import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_officer/DialogBox/ProductDialogContent.dart';

import 'DialogContent.dart';

class ProductDialogBox extends StatefulWidget {
  final List index;

  ProductDialogBox(this.index);

  @override
  _ProductDialogBoxState createState() => _ProductDialogBoxState();
}

class _ProductDialogBoxState extends State<ProductDialogBox>
    with SingleTickerProviderStateMixin {
  final bool status = true;

  var controller;
  var scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xffF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: SizedBox(
                height: 500,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ProductDialogContent(widget.index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
