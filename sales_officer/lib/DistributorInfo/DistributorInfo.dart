import 'package:flutter/material.dart';

class DistributorInfo extends StatelessWidget {
  final Function _setIndex;

  DistributorInfo(this._setIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: GestureDetector(
        onTap: () {
          _setIndex(4);
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0, top: 5),
                      child: Text("Bihani Suppliers", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                      Column(
                        children: [
                          ["Name: ", "Bihani Suppliers"],
                          ["Location: ", "34.222, 98.234"],
                          ["Phone Number: ", "9863643493"],
                          ["PAN: ", "1234567"],
                          ["Address: ", "Durbar Sq, Bhaktapur"],
                          ["Type: ", "Distributor A"],
                          ["Assigned Beat: ", "Dhumbarahi Beat 1"],
                        ]
                            .map((e) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(e[0]),
                                        Expanded(child: Container()),
                                        Text(e[1], style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Divider(
                                        thickness: 2,
                                        color: Colors.black.withOpacity(0.1),

                                      ),
                                    ),
                                  ],
                                ))
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
    );
  }
}
