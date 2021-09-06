import 'package:flutter/material.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(
        children: [
          Material(
          color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Enter the reason for your leave", style: TextStyle(fontSize: 25),),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      minLines: null,
                      maxLines: null,
                      expands: true,
                    ),
                  ),
                )),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
              ),
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
