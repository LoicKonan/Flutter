import 'package:agsoft/components/app_bar.dart';
import 'package:agsoft/utilities/user_secure_storage.dart';
import 'package:agsoft/views/card_views/card_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:agsoft/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agsoft/views/testview/testview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _name;
  String? _token;
  TextEditingController? _controller;
  void loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('username');
    print('MOTHER FUCKING NAME IS $_name');
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            _name = prefValue.getString('username') ?? '';
            _controller = new TextEditingController(text: _name);
            _token = prefValue.getString('token') ?? '';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff862633),
        title: const Text('AgSoft'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset('assets/images/mwsu2.png', fit: BoxFit.cover),
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Icon(Icons.more_vert),
          //     )),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Color(0xFFf0d578),
        margin: EdgeInsets.all(0),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFecac00),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3D550C),
              ),
              child: Text(
                "Welcome $_name!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestView(),
                      ));
                },
                icon: Icon(Icons.message),
              ),
              title: Text("Messages"),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
              title: Text('Profile'),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
              title: Text('Settings'),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.people_outline),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardWidgetView(),
                      ));
                },
              ),
              title: Text('Classes'),
            ),
          ],
        ),
      ),
    );
  }
}
