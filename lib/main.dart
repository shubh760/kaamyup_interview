import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/bnb.dart';
import 'package:kaamyup_interview/home.dart';
import 'package:kaamyup_interview/image_pick.dart';
import 'package:kaamyup_interview/login.dart';
import 'package:kaamyup_interview/methAndPro/home_provider.dart';
import 'package:kaamyup_interview/methAndPro/methods.dart';
import 'package:kaamyup_interview/otp_page.dart';
import 'package:kaamyup_interview/profile_page.dart';
import 'package:kaamyup_interview/signin.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
     
    );
  }
}
