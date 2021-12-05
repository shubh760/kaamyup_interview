import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kaamyup_interview/methAndPro/otpauth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phonecontroller = TextEditingController();
  Authclass authclass = Authclass();
  String verificationID = "";
  String smscode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text('OTP Verification',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 60),
                textfield(),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.grey,
                      )),
                      Text(
                        '  Enter 6 Digit OTP  ',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.grey,
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                otptextfield(),
                SizedBox(
                  height: 40,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Send OTP Again in ',
                      style: TextStyle(
                          color: Colors.white60, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '00:$start ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'sec ',
                      style: TextStyle(
                          color: Colors.white60, fontWeight: FontWeight.bold)),
                ])),
                SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  onTap: () {
                    authclass.signinWithPhone(
                        verificationID, smscode, phonecontroller.text, context);
                  },
                  child: Container(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: const [Colors.red, Colors.orange]),
                          borderRadius: BorderRadius.circular(18))),
                ),
              ],
            ),
          ),
        ));
  }

  void timer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otptextfield() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 20,
      fieldWidth: 55,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Color(0xff1d1d1d), borderColor: Colors.white),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (pin) {
        print("null");
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smscode = pin;
        });
      },
    );
  }

  Widget textfield() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xff1d1d1d), borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        controller: phonecontroller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: " Enter Your Number Here",
            hintStyle: TextStyle(color: Colors.white54),
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
              child: Text(
                '(+91)',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () async {
                      timer();
                      setState(() {
                        start = 30;
                        wait = true;
                        buttonName = "Resend";
                      });
                      await authclass.verifyPhoneNum(
                          "+91 ${phonecontroller.text}", context, setdata);
                    },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                child: Text(
                  buttonName,
                  style: TextStyle(
                      color: wait ? Colors.grey : Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }

  void setdata(verificationID) {
    setState(() {
      verificationID = verificationID;
    });
    timer();
  }
}
