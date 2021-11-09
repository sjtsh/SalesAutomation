import 'package:flutter/material.dart';
import 'package:sales_officer/Database.dart';

class ConfirmationRecieptWarning extends StatelessWidget {
  final List tempBillingAmounts;

  ConfirmationRecieptWarning(this.tempBillingAmounts);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, right: 12, left: 12),
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
                children: tempBillingAmounts
                    .map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              Builder(
                                builder: (context) {
                                 try {
                                  return Text(
                                    allBillingCompanysLocal
                                        .firstWhere((element) =>
                                            element.billingCompanyID == e[0])
                                        .billingCompanyName,
                                  );
                                }catch (e){
                                   return Text(
                                   "unnamed"
                                   );
                                 }
                              }
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text("Rs. ${e[1]} (${e[2]} day)"),
                            ],
                          ),
                          SizedBox(
                            height: 12,
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
    );
  }
}
