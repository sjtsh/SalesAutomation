import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/Header.dart';
import 'package:sales_officer/MoreScreen/FAQScreen/FAQExpandablePanel.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(10, false),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Frequently Asked Questions: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                  Column(
                    children: [
                      "Bugs Related Questions",
                      "System Related Questions",
                      "App Related Questions",
                      "Products Related Questions",
                      "Salary Related Questions",
                    ]
                        .map(
                          (e) => FAQExpandablePanel(e ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
