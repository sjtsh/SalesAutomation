import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_officer/MoreScreen/ProductsScreen/ProductsDetail.dart';

import '../../Header.dart';

class OurProductsScreen extends StatelessWidget {
  final Function refresh;

  OurProductsScreen(this.refresh);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(17, false, refresh),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Center(
                              child: TextField(
                                cursorColor: Colors.black,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  icon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  hintText: "Search Products",
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontSize: 16,
                                  ),
                                ),
                                // onChanged: (_products) {
                                //   if(_products != ""){
                                //     searchForProducts(_products, widget._setProducts);
                                //   }
                                //   else{
                                //     widget._setProducts(allSubGroupsLocal);
                                //   }
                                // }
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        ["Chiura", "products/Chiura.png"],
                        ["Chia Seeds", "products/chiaSeed.png"],
                        [
                          "Oats",
                          "products/Oats.png",
                        ]
                      ]
                          .map(
                            (f) => Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      f[0],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      "View All",
                                      style:
                                          TextStyle(color: Color(0xffFC5E05)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Color(0xffFC5E05)),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: ["", "", "", "", ""]
                                        .map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 3,
                                                      offset: Offset(0, 2))
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.white,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return ProductsDetail(refresh);
                                                    }));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Image.asset(
                                                          f[1],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(
                                                          "Kurum Kurum Chiura"),
                                                      Text(
                                                        "Rs. 132",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffFC5E05)),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
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
