import 'package:agsoft/Models/user.dart';
import 'package:agsoft/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:agsoft/views/registration_view/models/user.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? firstName;
  String? username;
  String? lastName;
  String? email;
  String? password;
  bool obscureText = true;

  Future<void> login() async {
    print('*****************************');
    final uri = 'http://localhost:8000/register';
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    final response = await http.post(
      Uri.parse(uri),
      body: map,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildFirstNameField() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'First Name',
              labelStyle: TextStyle(color: Colors.black87),
              prefixIcon: Icon(
                Icons.add_circle_rounded,
                color: Color(0xFF582f0e),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: .25))),
          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return 'First name is required';
            }
          },
          onSaved: (String? value) {
            firstName = value;
          },
        ));
  }

  Widget _buildLastNameField() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Last Name',
              labelStyle: TextStyle(color: Colors.black87),
              prefixIcon: Icon(
                Icons.add_circle_rounded,
                color: Color(0xFF582f0e),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: .25))),
          validator: (String? value) {
            if (value != null && value.isEmpty) {
              return 'Last name is required';
            }
          },
          onSaved: (String? value) {
            firstName = value;
          },
        ));
  }

  Widget _buildEmailField() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: EmailValidator(errorText: 'Not a valid email'),
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black87),
              prefixIcon: Icon(
                Icons.mail_sharp,
                color: Color(0xFF582f0e),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: .25))),

          onSaved: (String? value) {
            email = value;
          },
        ));
  }

  Widget _buildPasswordField(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .3,
        alignment: Alignment.center,
        child: TextFormField(
          obscureText: true,
          style: const TextStyle(color: Color(0xff582f0e)),
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
            }
          },
          onSaved: (String? value) {
            password = value;
          },
        ));
  }

  Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  Widget _login_button(BuildContext context) {
    return TextButton(
      child: const Text(
        'Already have an account? Login...',
        style: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        primary: const Color(0xff582f0e),
      ),
    );
  }

  Widget _registration_button(BuildContext context) {
    return Container(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xff862633),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0))),
      onPressed: () {}, // onPressed
      child: const Text('Register'),
      // style: ElevatedButton.styleFrom(
      //     shape: new RoundedRectangleBorder(
      //         borderRadius: new BorderRadius.circular(7.0))),
    ));
    // style:
    // ElevatedButton.styleFrom(
    //     shape: new RoundedRectangleBorder(
    //         borderRadius: new BorderRadius.circular(20.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0d578),
      appBar: const CustomAppBar(
          title: 'Registration', backgroundColor: const Color(0xff862633)),
      body: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.all(50),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // TextFormField(
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(), labelText: "Email"),
              // )
              _buildFirstNameField(),
              const SizedBox(height: 5),
              _buildLastNameField(),
              const SizedBox(height: 5),
              _buildEmailField(),
              const SizedBox(height: 5),
              _buildPasswordField(context),
              const SizedBox(height: 10),
              _registration_button(context),
              const SizedBox(
                height: 20,
              ),
              _login_button(context),
            ],
          ),
        ),
      ),
    );
  }
}
