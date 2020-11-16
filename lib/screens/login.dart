import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  Login({Key key, @required this.auth, @required this.firestore})
      : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: "Email"),
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: "Password"),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    key: ValueKey('signIn'),
                    onPressed: () async {
                      final String retVal = await Auth(auth: widget.auth)
                          .signIn(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (retVal == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(retVal),
                          ),
                        );
                      }
                    },
                    child: Text('Sign In'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    key: ValueKey('createAccount'),
                    onPressed: () async {
                      final String retVal = await Auth(auth: widget.auth)
                          .createAccount(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (retVal == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(retVal),
                          ),
                        );
                      }
                    },
                    child: Text('Create Account'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
