import 'package:flutter/material.dart';

class SingularPending extends StatelessWidget {
  final List e;

  SingularPending(this.e);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    e[0] as String,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                      color: e[3] as bool ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color:
                              e[3] as bool ? Colors.transparent : Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        "pending",
                        style: TextStyle(
                            color: e[3] as bool ? Colors.white : Colors.black),
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
                            padding: const EdgeInsets.only(bottom: 2.0),
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
              SizedBox(
                height: 10,
              ),
              Text(
                "Order ID : #${e[1]}",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              Text(
                "Order Amount : ${e[2]}",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
