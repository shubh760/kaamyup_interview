import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kaamyup_interview/methAndPro/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    context.read<ThreeData>().fetchCardata;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: AnimSearchBar(
            width: MediaQuery.of(context).size.width - 40,
            textController: textController,
            rtl: true,
            onSuffixTap: () {
              textController.clear();
            },
            closeSearchOnSuffixTap: true,
            suffixIcon: Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: Consumer<ThreeData>(
            builder: (context, value, child) {
              return value.map.length == 0 && !value.error
                  ? CircularProgressIndicator()
                  : value.error
                      ? Center(
                        child: Text(
                            'Oops Something ent wrong: ${value.errormsg}',style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                      )
                      : ListView.builder(
                          itemCount: value.map['cars'].length,
                          itemBuilder: (context, index) {
                            return Infocard(mapa: value.map['cars'][index]);
                          });
            },
          ),
        ),
      ),
    );
  }
}

class Infocard extends StatelessWidget {
  const Infocard({Key? key, required this.mapa}) : super(key: key);
  final Map<String, dynamic> mapa;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network('${mapa['img']}'),
            SizedBox(height: 10,),
            Text('Car name: ${mapa['name']}', style: TextStyle(color: Colors.white),),
            SizedBox(height: 10,),
             Text('Car Milage: ${mapa['mileage'].toString()}', style: TextStyle(color: Colors.white),),
            SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}
