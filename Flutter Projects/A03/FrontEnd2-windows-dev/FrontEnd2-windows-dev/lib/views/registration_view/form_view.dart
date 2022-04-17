import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? username;
  String? fullname;
  String? password;
  String? email;
  TextEditingController unController = new TextEditingController();
  TextEditingController fullnameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Color(0xFFf0d578),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(50),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildFullName(),
              SizedBox(
                height: 5,
              ),
              _buildUserName(),
              SizedBox(
                height: 10,
              ),
              _buildEmail(context),
              SizedBox(
                height: 10,
              ),
              _buildPasswordField(),
              SizedBox(
                height: 10,
              ),
              _register_button(context)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    final uri = 'http://157.245.141.117:8000/register';
    final body = {
      "username": unController.text,
      "fullname": fullnameController.text,
      "email": emailController.text,
      "disabled": false,
      "password": passwordController.text
    };
    var json_string = json.encode(body);
    print(body);
    print(json_string);
    var response;
    try {
      response = await http.post(
        Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: json_string,
      );
    } catch (e) {
      print(e);
    }

    if (response.statusCode == 200) {
      print(response.statusCode);
      Navigator.pop(context);
    } else {
      print(response.statusCode);
      final snackBar = SnackBar(
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {},
          ),
          content: Text('Something went wrong'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _register_button(BuildContext context) {
    return Container(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color(0xff862633),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0))),
      onPressed: register,
      child: Text('Register'),
    ));
  }

  Widget _buildPasswordField() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          controller: passwordController,
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
              return 'Uppercase, number, special character required';
            } else {
              password = value;
            }
          },
        ));
  }

  Widget _buildEmail(context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          controller: emailController,
          onSaved: (String? value) {
            email = value;
          },
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black87),
              prefixIcon: Icon(
                Icons.add_circle_rounded,
                color: Color(0xFF582f0e),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black87, width: .25))),
          validator: (value) => validateEmail(value),
        ));
  }

  Widget _buildFullName() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          controller: fullnameController,
          onSaved: (String? value) {
            fullname = value;
          },
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Full Name',
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
              return 'Fullname is required';
            } else {
              fullname = value;
            }
          },
        ));
  }

  Widget _buildUserName() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          controller: unController,
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
              return 'Username is required';
            } else {
              username = value;
            }
          },
        ));
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else {
      email = value;
      return null;
    }
  }
}
