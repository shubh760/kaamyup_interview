import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/home.dart';
import 'package:kaamyup_interview/image_pick.dart';
import 'package:kaamyup_interview/otp_page.dart';

import 'methAndPro/methods.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoding = false;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  void showdialouge() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text("Add Notes"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "User Already Exist",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Text("ok"),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: isLoding
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Center(
              child: Form(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: usernameTextController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return " please enter Username";
                              } else if (value!.length < 6) {
                                return " Please enter Username longer then 6 letter";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                hintText: "Type your name here",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.red.shade800)),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                                label: Text(
                                  "username",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailTextController,
                            validator: (value) {
                              return EmailValidator.validate(value!)
                                  ? null
                                  : "Please enter a valid E-mail";
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                hintText: "Type your e-mail here",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.red.shade800)),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    )),
                                label: Text(
                                  "e-mail",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordTextController,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return " please enter Password";
                              } else if (value!.length < 6) {
                                return " Please enter Password longer then 6 letter";
                              }
                              return null;
                            },
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                hintText: "Type your password here",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.red.shade800)),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    )),
                                label: Text(
                                  "password",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoding = true;
                                });
                                createAccount(
                                        usernameTextController.text,
                                        emailTextController.text,
                                        passwordTextController.text)
                                    .then((_user) {
                                  if (User != null) {
                                    setState(() {
                                      isLoding = false;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OtpPage()));
                                    });
                                  } else {
                                    showdialouge();
                                  }
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: const [
                                        Colors.red,
                                        Colors.orange
                                      ]),
                                      borderRadius: BorderRadius.circular(18))),
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "SignUp with Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18))),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
