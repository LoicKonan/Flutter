import 'package:agsoft/components/app_bar.dart';
import 'package:agsoft/views/card_views/card_view.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:agsoft/Models/user.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFc2c5aa),
      appBar: CustomAppBar(
        backgroundColor: Color(0xff414833),
        title: "Home",
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(150),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
