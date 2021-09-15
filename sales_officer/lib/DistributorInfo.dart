import 'package:flutter/material.dart';
import 'package:sales_officer/Header.dart';

import 'BACKEND/Entities/Distributor.dart';
import 'BACKEND/Methods/method.dart';

class DistributorInfo extends StatelessWidget {
  final Distributor currentDistributor;

  DistributorInfo(this.currentDistributor);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children: [
            Header(0, false),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              getInitials(currentDistributor.distributorName),
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: Text(
                            currentDistributor.distributorName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Column(
                              children: [
                                ["Name: ", currentDistributor.distributorName],
                                ["Owner Name: ", currentDistributor.ownerName],
                                [
                                  "Phone Number: ",
                                  currentDistributor.phone.toString()
                                ],
                                [
                                  "Mobile Number: ",
                                  currentDistributor.mobileNumber.toString()
                                ],
                                [
                                  "PAN Number: ",
                                  currentDistributor.PAN.toString()
                                ],
                                ["Address: ", currentDistributor.location],
                                [
                                  "Bank Account Name: ",
                                  currentDistributor.bankAccountName
                                ],
                                [
                                  "Bank Account Number: ",
                                  currentDistributor.bankAccountNumber.toString()
                                ],
                                [
                                  "Bank Address: ",
                                  currentDistributor.bankAddress
                                ],
                                [
                                  "VAT Number: ",
                                  currentDistributor.VAT.toString()
                                ],
                                [
                                  "Geo: ",
                                  currentDistributor.lat.toString() +
                                      ", " +
                                      currentDistributor.lng.toString()
                                ],
                              ]
                                  .map((e) => Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Row(
                                              children: [
                                                Text(e[0]),
                                                Expanded(child: Container()),
                                                Text(
                                                  e[1],
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Divider(
                                              thickness: 1,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Text("Assigned Beat: "),
                                  Expanded(child: Container()),
                                  Text(
                                    "Dhumbarahi Beat 1",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Wrap(
                              children: [
                                "Beat1",
                                "Beat2",
                                "Beat3",
                                "Beat4",
                                "Beat5",
                                "Beat6"
                              ]
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Color(0xffe0e0e0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8),
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
