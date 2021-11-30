import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/methAndPro/methods.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imgurl = '';
  String name = '';
  String number = '';
  String email = '';
  Future getimage() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot ds) {
      if(mounted){
        setState(() {
        imgurl = ds["imageurl"];
        name = ds["name"];
        number = ds["Phone num"];
        email = ds["email"];
      });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    getimage();
    return Scaffold(
      backgroundColor: Colors.black,
      body:imgurl ==null? CircularProgressIndicator(): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'User Profile',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Stack(children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 110,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Colors.red, Colors.orange])),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage('${imgurl}'),
                  ),
                ),
              ]),
              SizedBox(
                height: 80,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.orange])),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "${name}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.orange])),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    "${email}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.orange])),
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    "${number}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
