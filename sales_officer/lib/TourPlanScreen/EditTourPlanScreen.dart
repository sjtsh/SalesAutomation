import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_officer/TourPlanScreen/TourDropDowns.dart';

import '../Database.dart';
import '../Header.dart';
import 'ModalSheet/ModalSheetTourPlan.dart';
import 'TourPlanScreen.dart';

class EditTourPlanScreen extends StatefulWidget {
  final int startDate;
  final int endDate;
  final DateTime now;

  EditTourPlanScreen(this.startDate, this.endDate, this.now);

  @override
  _EditTourPlanScreenState createState() => _EditTourPlanScreenState();
}

class _EditTourPlanScreenState extends State<EditTourPlanScreen> {
  bool isModal = false;
  bool condition = false;
  String? todayText;
  Function? setActivity;
  Function? setDetail;
  int? index;
  List? allTourPlans;
  bool isFillDisabled = true;

  setTourPlan(List aList, index) {
    bool condition = false;
    allTourPlans![index] = aList;
    allTourPlans!.forEach((element) {
      if (element[2] == null) {
        condition = true;
      }
    });
    isFillDisabled = condition;
  }

  setIsModalTrue(
      String todayText, Function setActivity, Function setDetail, int index) {
    this.condition = condition;
    this.todayText = todayText;
    this.setActivity = setActivity;
    this.setDetail = setDetail;
    this.index = index;
    setState(() {
      isModal = true;
    });
  }

  setIsModalFalse() {
    setState(() {
      isModal = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allTourPlans = List.generate(
        widget.endDate - widget.startDate + 1, (index) => [null, null, null]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              Header(7, false),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.1)))),
                height: 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Date",
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                        Center(
                          child: Text(
                            "${widget.startDate}/${widget.now.month - 1}/${widget.now.year}",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        "icons/bothsidearrow.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "End Date",
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),
                        Text(
                          "${widget.endDate - dates[widget.now.month - 1]}/${widget.now.month}/${widget.now.year}",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
              TourDropDowns(
                  widget.startDate, widget.endDate, widget.now, setIsModalTrue, allTourPlans!),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MaterialButton(
                    color: isFillDisabled ? Colors.blueGrey : Colors.green,
                    onPressed: () {
                      if (isFillDisabled) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Fill All Fields"),
                        ));
                      } else {
                        print(allTourPlans);
                      }
                    },
                    child: Center(
                      child: Text(
                        "FILL",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isModal
              ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.1),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 2 / 3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: ModalSheetTourPlan(todayText!, setActivity!,
                              setDetail!, index!, setIsModalFalse, setTourPlan),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
