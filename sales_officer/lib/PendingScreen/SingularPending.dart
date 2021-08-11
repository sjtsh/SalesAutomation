import 'package:flutter/material.dart';
import 'package:sales_officer/PendingScreen/ApproveOrderScreen.dart';

class SingularPending extends StatelessWidget {
  final List e;

  SingularPending(this.e);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return ApproveOrderScreen(e);
              },
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: Offset(0, 2))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEA47B2),
                        ),
                        child: Center(
                            child: Text(
                          e[0].split(" ")[0].substring(0, 1) +
                              e[0].split(" ")[1].substring(0, 1),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8),
                        )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        e[0] as String,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: e[4] as bool
                              ? Color(0xffFFCE31)
                              : Color(0xff60D74D),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            e[4] as bool ? "PENDING" : "APPROVED",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Column(
                        children: ["", "", ""]
                            .map(
                              (f) => Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Container(
                                  height: 3,
                                  width: 3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        "Order ID :",
                        style: TextStyle(color: Colors.black.withOpacity(0.5),),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "#${e[1]}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        "Order Date :",
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "${e[2]}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        "Order Amount :",
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Rs ${e[3]}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
