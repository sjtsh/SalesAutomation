import 'package:flutter/material.dart';

class SignInCred extends StatefulWidget {
  final _formKey;
  final TextEditingController _username;
  final TextEditingController _password;

  SignInCred(this._formKey, this._username, this._password);

  @override
  _SignInCredState createState() => _SignInCredState();
}

class _SignInCredState extends State<SignInCred> {
  bool visible = false;

  @override
  void dispose() {
    widget._username.dispose();
    widget._password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, top: 5),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
                child: TextFormField(
                  controller: widget._username,
                  textAlignVertical: TextAlignVertical.center,
                  enableSuggestions: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Please enter your username'),
                      ));
                      return '';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your username here",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                    ),
                    icon: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, top: 5),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: visible ? false : true,
                      controller: widget._password,
                      textAlignVertical: TextAlignVertical.center,
                      enableSuggestions: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Please enter your password'),
                          ));
                          return '';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your password here",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -30,
                      top: -3,
                      child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          height: 60,
                          onPressed: () {
                            setState(
                              () {
                                visible = !visible;
                              },
                            );
                          //   try {
                          //     final res = await http.delete(
                          //       Uri.parse(
                          //           "https://asia-south1-hilifedb.cloudfunctions.net/deleteDistributorOrderItem"),
                          //       headers: <String, String>{
                          //         'Content-Type': 'application/json; charset=UTF-8',
                          //       },
                          //       body: jsonEncode(
                          //         <String, String>{
                          //           'distributorOrderItemID': "33",
                          //         },
                          //       ),
                          //     );
                          //     print(res.body.toString() +
                          //         "________________________________________________________");
                          //   }
                          //   catch(e) {
                          //     print("the http request wasn't successful");
                          //   }
                          },
                          child: Icon(visible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
