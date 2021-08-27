import 'package:flutter/material.dart';
import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Methods/createOrder.dart';
import 'package:sales_officer/Database.dart';

class ConfirmationReciept extends StatefulWidget {
  final Distributor currentDistributor;
  final List<TextEditingController> _textEditingControllers;
  final List receiptData;

  ConfirmationReciept(
      this.currentDistributor, this._textEditingControllers, this.receiptData);

  @override
  _ConfirmationRecieptState createState() => _ConfirmationRecieptState();
}

class _ConfirmationRecieptState extends State<ConfirmationReciept> {
  Text getTotalItems() {
    num _total = 0;
    widget.receiptData.forEach((element) {
      _total = _total + element[1];
    });
    return Text(_total.toString());
  }

  List getSubGroupItems(int i) {
    List items = [];
    widget.receiptData.forEach((element) {
      if (element[0].subGroupID == i) {
        items.add(element);
      }
    });
    return items;
  }

  List<int> getSubProducts() {
    List<int> subProducts = [];
    widget.receiptData.forEach((element) {
      if (!subProducts.contains(element[0].subGroupID)) {
        subProducts.add(element[0].subGroupID);
      }
    });
    print(subProducts);
    return subProducts;
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
              Text(
                " Pcs",
                style: TextStyle(fontSize: 12),
              ),
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
                height: 20,
              ),
              Column(
                children: getSubProducts()
                    .map(
                      (e) => Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, right: 20, left: 20),
                              child: Row(
                                children: [
                                  Text(
                                    allSubGroupsLocal[e].subGroupName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(getSubGroupItems(e).length.toString()),
                                  Text(
                                    " Pcs",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: getSubGroupItems(e)
                                  .map(
                                    (f) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                f[0].SKUName,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              )),
                                          Expanded(child: Container()),
                                          Text(
                                            widget
                                                ._textEditingControllers[
                                                    allSKULocal.indexOf(f[0])]
                                                .text,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          Text(
                                            " Pcs",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                widget.receiptData.remove(f);
                                              });
                                            },
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      createOrder(widget.currentDistributor.distributorID, widget._textEditingControllers, context);
                    },
                    child: Center(
                      child: Text(
                        "CONFIRM",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
