import 'package:agsoft2/views/card_views/card_view.dart';
import 'package:agsoft2/views/card_views/response/compilation_view.dart';
import 'package:agsoft2/views/drag_drop/drag_drop.dart';
import 'package:flutter/material.dart';
import 'package:agsoft2/views/login_form/login_view.dart';
import 'package:agsoft2/views/home_screen/home_screen.dart';
import 'package:agsoft2/views/registration_view/form_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      routes: {
        '/compilation': (context) => CompilationView(),
        '/drag': (context) => DragFile(),
        '/second': (context) => const HomeScreen(),
        '/registration': (context) => FormScreen(),
        '/upload': (context) => UploadFiles(),
      },
      theme: ThemeData(scaffoldBackgroundColor: const Color(0x0000000)),
    );
  }
}
