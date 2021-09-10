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
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: widget._username,
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
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
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
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                visible = !visible;
                              },
                            );
                          },
                          child: Icon(
                            visible ? Icons.visibility : Icons.visibility_off,
                            color: visible ? Colors.blue : Colors.black.withOpacity(0.5),
                          )),
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
