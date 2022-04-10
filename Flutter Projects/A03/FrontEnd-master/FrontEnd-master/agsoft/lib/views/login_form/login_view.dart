import 'package:agsoft/Models/user.dart';
import 'package:agsoft/components/app_bar.dart';
import 'package:agsoft/utilities/user_secure_storage.dart';
import 'package:agsoft/views/home_screen/home_screen.dart';
import 'package:agsoft/views/registration_view/form_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginViewState extends State<LoginView> {
  String? username;
  String? password;
  String token = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFf0d578),
      appBar: CustomAppBar(
        backgroundColor: Color(0xff862633),
        title: "Welcome to AGsoft",
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(50),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildUserName(),
              _buildPasswordField(),
              SizedBox(
                height: 10,
              ),
              _login_button(context),
              const SizedBox(
                height: 20,
              ),
              _registration_button(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildPasswordField() {
  //   return Container(
  //     width: 200,
  Widget _buildUserName() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          onSaved: (String? value) {
            username = value;
          },
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'User Name',
              labelStyle: TextStyle(color: Colors.black87),
              prefixIcon: Icon(
                Icons.add_circle_rounded,
                color: Color(0xFF582f0e),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black87, width: .25))),
          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return 'First name is required';
            } else {
              username = value;
            }
          },
        ));
  }

  Widget _buildPasswordField() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          onSaved: (String? value) {
            password = value;
          },
          obscureText: true,

          style: TextStyle(color: Color(0xff582f0e)),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color(0xFF582f0e)),
              fillColor: Colors.purpleAccent,
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black87),
              prefixIcon: Icon(
                Icons.mail_sharp,
                color: Color(0xFF582f0e),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: .25))),

          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return 'Password is required!';
            }
            if (!RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(value!)) {
              return 'Please enter a valid password!';
            } else {
              password = value;
            }
          },
        ));
  }

  Widget _registration_button(BuildContext context) {
    return TextButton(
      child: Text(
        'Register for an account!',
        style: TextStyle(fontSize: 30),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen()),
        );
      },
      style: TextButton.styleFrom(
        primary: Color(0xff000000),
      ),
    );
  }

  Widget _login_button(BuildContext context) {
    return Container(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color(0xff862633),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0))),
      onPressed: login, //() {
      //   // login();
      //   print('Passoword = $password');
      //   print('Username = $username');
      //   login();

      //   // login();
      // }, // onPressed
      child: Text('Login'),
      // style: ElevatedButton.styleFrom(
      //     shape: new RoundedRectangleBorder(
      //         borderRadius: new BorderRadius.circular(7.0))),
    ));
    // style:
    // ElevatedButton.styleFrom(
    //     shape: new RoundedRectangleBorder(
    //         borderRadius: new BorderRadius.circular(20.0)));
  }

  Future<void> login() async {
    print('*****************************');
    final uri = 'http://157.245.141.117:8000/token';
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    final response = await http.post(
      Uri.parse(uri),
      body: map,
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      token = convert.jsonDecode(response.body)['access_token'];
      print(token);
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', token);
      sp.setString('username', username!);

      print("######################################################");
      print(sp.getString('username'));
      print(sp.getString('token'));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      final snackBar = SnackBar(
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {},
          ),
          content: Text('Incorrect password/username'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // var url =
    //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

    // // Await the http get response, then decode the json-formatted response.
    // var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse =
    //       convert.jsonDecode(response.body) as Map<String, dynamic>;
    //   var itemCount = jsonResponse['totalItems'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }
}
