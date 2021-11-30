import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaamyup_interview/bnb.dart';
import 'package:kaamyup_interview/home.dart';
import 'package:kaamyup_interview/profile_page.dart';
import 'package:uuid/uuid.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File? image;
  String imageurl = '';
  bool isloading = false;

  Future PickImageCam(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() => this.image = temporaryImage);
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }

  Future uploadImage() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String imagename = Uuid().v1();

    var ref =
        FirebaseStorage.instance.ref().child('image').child('$imagename.jpg');

    var uploadtask = await ref.putFile(image!);

    imageurl = await uploadtask.ref.getDownloadURL();
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set({"imageurl": imageurl}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            onTap: () {
              uploadImage();
              setState(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BNB ()));
              });
            },
          )
        ],
      ),
      body: Center(
        child: Form(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Upload your Profile picture here",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  SizedBox(
                    height: 60,
                  ),
                  image != null
                      ? ClipOval(
                          child: Image.file(
                            image!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )
                      : FlutterLogo(
                          size: 160,
                        ),
                  SizedBox(
                    height: 80,
                  ),
                  Text("Add your image here"),
                  SizedBox(),
                  GestureDetector(
                    onTap: () => PickImageCam(ImageSource.gallery),
                    child: Container(
                        child: Text(
                          "Image from galary",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: const [Colors.red, Colors.orange]),
                            borderRadius: BorderRadius.circular(18))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => PickImageCam(ImageSource.camera),
                    child: Container(
                        child: Text("Image from camera",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: const [Colors.red, Colors.orange]),
                            borderRadius: BorderRadius.circular(18))),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
