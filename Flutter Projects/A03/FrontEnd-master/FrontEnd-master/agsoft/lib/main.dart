import 'package:agsoft/views/card_views/card_view.dart';
import 'package:flutter/material.dart';
import 'package:agsoft/views/login_form/login_view.dart';
import 'package:agsoft/views/home_screen/home_screen.dart';
import 'package:agsoft/views/registration_view/form_view.dart';
import 'package:agsoft/views/testview/testview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      routes: {
        '/second': (context) => HomeScreen(),
        '/registration': (context) => FormScreen(),
        '/class': (context) => CardWidgetView(),
        '/test': (context) => TestView(),
      },
      theme: new ThemeData(scaffoldBackgroundColor: Color(0x0000000)),
    );
  }
}
