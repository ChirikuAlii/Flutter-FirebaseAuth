import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  bool success = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Email",
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  style: TextStyle(fontSize: 20),
                  controller: emailText,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: TextField(
                    decoration: InputDecoration(
                        labelText: "Enter Your new Password",
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8)),
                    style: TextStyle(fontSize: 20),
                    controller: passwordText),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: ElevatedButton(
                    child: Text("Register"),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 18),
                        minimumSize: Size(double.infinity, 45)),
                    onPressed: () async {
                      await doRegister();
                    }),
              ),
            ],
          ),
        ));
  }

  Future<void> doRegister() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailText.text,
      password: passwordText.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        success = true;
      });
      print("do register success $success");
    } else {
      setState(() {
        success = false;
      });
      print("do register failed $success");
    }
  }
}
