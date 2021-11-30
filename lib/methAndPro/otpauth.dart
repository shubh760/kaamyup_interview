import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/image_pick.dart';

class Authclass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Void?> verifyPhoneNum(
      String phoneNumber, BuildContext context, Function setdata) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showsnakbar(context, "Verification Completed");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) async {
      showsnakbar(context, exception.toString());
    };
    PhoneCodeSent codeSent = (String verificationID, [int? forceResendToken]) {
      showsnakbar(context, "OTP has been sent your number");
      setdata(verificationID);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showsnakbar(context, "Time Out");
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showsnakbar(context, e.toString());
    }
  }

  Future<void> signinWithPhone(String verificationid, String smsCode,
      TextEditingController controller, BuildContext context) async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationid, smsCode: smsCode);

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"Phone num": controller.toString()}, SetOptions(merge: true));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ImagePick()));
    } catch (e) {
      showsnakbar(context, e.toString());
    }
  }

  void showsnakbar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
