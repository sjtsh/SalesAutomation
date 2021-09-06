import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_officer/TourPlanScreen/TourPlanScreen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawerHeader(
            child: SvgPicture.asset("icons/logo.svg"),
          ),
          Divider(
            color: Colors.red.withOpacity(0.5),
            thickness: 2,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("My Performance"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Change Beat"),
                  ),
                ),
                InkWell(
                  onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_){
                    return TourPlanScreen();
                  }));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Tour Plan"),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Share Order"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("FAQ"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
            clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              ),
              child: MaterialButton(
                color: Colors.green,
                minWidth: MediaQuery.of(context).size.width-24,
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "END DAY",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Text(
            "Version 0.0.0",
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }
}
