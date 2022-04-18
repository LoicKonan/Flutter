import 'package:desktop_drop/desktop_drop.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file/file.dart';

class DragFile extends StatefulWidget {
  DragFile({Key? key}) : super(key: key);

  @override
  State<DragFile> createState() => _DragFileState();
}

class _DragFileState extends State<DragFile> {
  Dio dio = Dio();
  List<dynamic>? classes;
  String? dropdownValue;
  final Set<dynamic> files = {};

  @override
  void initState() {
    super.initState();
    getClassData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff862633),
          title: const Text('AGsoft'),
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
          child: Column(
            children: [],
          ),
        ));
  }

  Future getClassData() async {
    Dio dio = Dio();
    var uri = 'http://157.245.141.117:8000/all_classes';
    var url = Uri.parse(uri);
    final api_data = await dio.get(uri);
    if (api_data.statusCode == 200) {
      // print(api_data.data['classes']);
      setState(() {
        classes = api_data.data['classes'];
        print(classes);
      });
    }
  }
}
