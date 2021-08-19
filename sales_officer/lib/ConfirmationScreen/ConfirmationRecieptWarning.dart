import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';

class ConfirmationRecieptWarning extends StatelessWidget {

  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;

  ConfirmationRecieptWarning(this.currentDistributor, this._textEditingControllers,
      this.receiptData);

  Text getTotalItems() {
    double _total = 0;
    receiptData.forEach((element) {
      _total = _total + element[1];
    });
    return Text(_total.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          child: Row(
            children: [
              Text(
                "Total Stock",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              getTotalItems(),
              Text(" Pcs"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                  blurRadius: 3)
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Cornflakes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: Container()),
                    Text("22 Pcs"),
                  ],
                ),
              ),
              Column(
                children: ["", ""]
                    .map(
                      (e) =>
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.1),
                                ))),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hilife Cornflakes Sugarfree"),
                                Text("410GM x 45Box"),
                              ],
                            ),
                            Expanded(child: Container()),
                            Text("15 Pcs"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                )
                    .toList(),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffEB6F6F),
                  ),
                  color: Color(0xffE85B5B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Can't place your order!"),
                          ],
                        ),
                      ),
                      Text(
                          "This is due to your limit, it has been exceeded for more than 45 days. Below are the details:"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Hilife Foods Enterprise",
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text("Rs. 20,000 (55 day)"),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rising Sun Agro",
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text("Rs. 13,000 (60 day)"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Total:",
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            "Rs 33,000",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffC8C8C8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffF2B200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Request for Approval",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
