import 'package:flutter/material.dart';

class DiscardPrompt extends StatelessWidget {
  const DiscardPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xffF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            height: 200,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Text(
                    "Discard Changes?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: Container()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Colors.blueGrey,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
