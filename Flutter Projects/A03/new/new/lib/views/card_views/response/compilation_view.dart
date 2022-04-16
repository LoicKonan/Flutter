import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompilationView extends StatefulWidget {
  CompilationView({Key? key}) : super(key: key);

  @override
  State<CompilationView> createState() => _CompilationViewState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _CompilationViewState extends State<CompilationView> {
  String? jsonString;
  Map<String, dynamic>? jsonMap;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            jsonString = prefValue.getString('map');
            jsonMap = json.decode(jsonString!);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff862633),
        title: const Text('Compilation Results'),
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
        child: Card(
          child: ExpandablePanel(
              header: Text(jsonMap?['student_name']),
              collapsed: collapsed,
              expanded: expanded),
        ),
      ),
    );
  }
}
