import 'package:agsoft2/components/app_bar.dart';
import 'package:agsoft2/utilities/user_secure_storage.dart';
import 'package:agsoft2/views/card_views/card_view.dart';
import 'package:agsoft2/views/drag_drop/drag_drop.dart';
import 'package:agsoft2/views/faq_page/faqs.dart';
import 'package:agsoft2/views/login_form/login_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:agsoft2/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print('My NAME IS $_name');
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
        title: const Text('AGsoft'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Testimonials',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'AGsoft has cost me my sanity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('-Buddy Smith'),
            SizedBox(
              height: 10,
            ),
            Text(
              'AGsoft has increased my workload by 4',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('- Dylan Huff'),
            SizedBox(
              height: 10,
            ),
            Text(
              'I LOVE the idea!!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('- Micah Morgan'),
            SizedBox(
              height: 10,
            ),
            Text(
              'I will never use this product',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('- Dr. Tina Johnson')
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFecac00),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff862633),
              ),
              child: Column(children: [
                Text(
                  "Welcome $_name!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ));
                      },
                    ),
                  ),
                )
              ]),
            ),
            Column(
              children: [],
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FAQS(),
                      ));
                },
                icon: Icon(Icons.message),
              ),
              title: Text("FAQs"),
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
                icon: Icon(Icons.people_outline),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadFiles(),
                      ));
                },
              ),
              title: Text('Upload Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}
