import 'package:flutter/material.dart';
import 'package:agsoft/views/login_form/login_view.dart';
import 'package:agsoft/views/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

// Main Driver for the application
// It call the widget build that will call for the
// HomeScreen and the LoginScreen.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      routes: {'/second': (context) => HomeScreen()},
      theme: new ThemeData(scaffoldBackgroundColor: Color(0x0000000)),
    );
  }
}
