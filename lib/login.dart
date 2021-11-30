import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/bnb.dart';
import 'package:kaamyup_interview/profile_page.dart';
import 'package:kaamyup_interview/signin.dart';
import 'home.dart';
import 'methAndPro/methods.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailtext = TextEditingController();
  TextEditingController passwordtext = TextEditingController();
  bool isLoading = false;
  void showdialouge() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text(
                  "User doesn't exist",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                content: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "ok",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Center(
              child: Form(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Log In",
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
                            controller: emailtext,
                            validator: (value) {
                              return EmailValidator.validate(value!)
                                  ? null
                                  : "Please enter a valid E-mail";
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                hintText: "Type your Email here",
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
                                  "Email",
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
                            controller: passwordtext,
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
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text("Forgot Password?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                if (emailtext.text.isNotEmpty &&
                                    passwordtext.text.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  logIn(emailtext.text, passwordtext.text)
                                      .then((_user) {
                                    if (_user != null) {
                                      setState(() {
                                        isLoading = false;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BNB()));
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showdialouge();
                                    }
                                  });
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Login",
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
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18)))),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have any account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(" Register now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
