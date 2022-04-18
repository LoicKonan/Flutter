import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_table_2/data_table_2.dart';

class CompilationView extends StatefulWidget {
  CompilationView({Key? key}) : super(key: key);

  @override
  State<CompilationView> createState() => _CompilationViewState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _CompilationViewState extends State<CompilationView> {
  String? jsonString;
  Map<String, dynamic>? jsonMap;
  String student_name = "";
  String comments = "";
  int commented_lines = 0;
  double comment_percentage = 0.0;
  String make_out = "";
  int make_return_code = 0;
  String? make_stderr;
  String? make_stdout;
  String results = "";
  String stdout = "";
  int total_lines = 0;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            jsonString = prefValue.getString('map');
            jsonMap = json.decode(jsonString!);
            student_name = jsonMap?['student_name'];

            //comments = jsonMap?['comments'][0]['file']['comments'];
            total_lines = jsonMap?['comments'][0]['file']['total_lines'];
            commented_lines = jsonMap?['comments'][0]['file']['lines'];
            comment_percentage =
                jsonMap?['comments'][0]['file']['comment_percentage'];

            // make_out = jsonMap?['make']['stdout'];
            make_return_code = jsonMap?['make']['returncode'];
            make_stderr = jsonMap?['make']['stderr'];
            make_stdout = jsonMap?['make']['stdout'];
            print(jsonMap?['make']);
            results = jsonMap?['results'];
            stdout = jsonMap?['stdout'];
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf0d578),
        appBar: AppBar(
          backgroundColor: Color(0xff862633),
          title: const Text('Compilation Results'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
              child: GestureDetector(
                onTap: () {},
                child:
                    Image.asset('assets/images/mwsu2.png', fit: BoxFit.cover),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Table(
                  columnWidths: {4: FlexColumnWidth(0.2)},
                  children: [
                    TableRow(children: [
                      Text('Student',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text(student_name,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Make Return Code',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text(make_return_code.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Total Lines',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text(total_lines.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Commented Lines',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text(commented_lines.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Commented Percentage',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text(comment_percentage.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Stdout',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text((() {
                        if (stdout == "") {
                          return "None";
                        }
                        return stdout;
                      })(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('File Output',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text((() {
                        if (results == "") {
                          return "None";
                        }
                        return results;
                      })(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Make Stdout',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text((() {
                        if (make_stdout == null) {
                          return "None";
                        }
                        return make_stdout!;
                      })(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Divider(),
                      Divider(),
                      Divider(),
                    ]),
                    TableRow(children: [
                      Text('Make Stderr',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_rounded),
                      Text((() {
                        if (make_stderr == null) {
                          return "None";
                        }
                        return make_stdout!;
                      })(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ]),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
