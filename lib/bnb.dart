import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/edit.dart';
import 'package:kaamyup_interview/home.dart';
import 'package:kaamyup_interview/profile_page.dart';
import 'package:provider/provider.dart';

import 'methAndPro/home_provider.dart';

class BNB extends StatefulWidget {
  const BNB({Key? key}) : super(key: key);

  @override
  _BNBState createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  int itemindex = 0;
  @override
  Widget build(BuildContext context) {
    final items = [Icon(Icons.home), Icon(Icons.person), Icon(Icons.edit)];

    final Screens = [
      ChangeNotifierProvider(
        create: (context) => ThreeData(),
        builder: (context, child) {
          return HomePage();
        },
      ),
      Profile(),
      EditProfile()
    ];
    return Scaffold(
      extendBody: true,
      body: Screens[itemindex],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.red,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.transparent,
        items: items,
        index: itemindex,
        onTap: (index) => setState(() => this.itemindex = index),
        height: 60,
      ),
    );
  }
}
