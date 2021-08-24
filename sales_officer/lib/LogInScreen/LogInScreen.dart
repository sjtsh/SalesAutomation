import 'package:flutter/material.dart';
import 'package:sales_officer/LogInScreen/SelectBeat.dart';

class LogInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          Expanded(child: Container()),
          Center(
            child: Container(
              height: 130,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "John Doe",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Sales Officer",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SelectBeat()));
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          )),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Start Retailing",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color:  Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Joint Working",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          )),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Leave/weak off",
                            style: TextStyle(
                                fontSize: 18,
                                color:Colors.black),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward,
                              color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
