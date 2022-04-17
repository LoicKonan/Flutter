import 'dart:convert';
import 'dart:io';

import 'package:agsoft2/components/app_bar.dart';
import 'package:agsoft2/views/card_views/response/compilation_view.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' as convert;
import 'dart:developer';

class UploadFiles extends StatefulWidget {
  UploadFiles({Key? key}) : super(key: key);

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  File? _cppFile;
  File? _inputFile;
  String? _cppFileName;
  String? _inputFileName;
  String? _cppUri;
  String? _inputUri;
  String? _className;
  String? _studentName;
  String? _assnNum;
  String? _inputName;
  String? _cppName;
  List<File> _files = [];
  Dio dio = Dio();
  var _inputBytes;
  var _cppBytes;
  TextEditingController classController = new TextEditingController();
  TextEditingController studentController = new TextEditingController();
  TextEditingController assignmentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0d578),
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
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(5.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _build_class_name(context),
              SizedBox(
                height: 10,
              ),
              _build_student_name(context),
              SizedBox(
                height: 10,
              ),
              _build_assn_num(context),
              SizedBox(
                height: 10,
              ),
              _cpp_upload_button(context),
              SizedBox(
                height: 10,
              ),
              _input_builder_button(context),
              SizedBox(
                height: 10,
              ),
              _submit_all_params(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _build_student_name(context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .25,
        alignment: Alignment.center,
        child: TextFormField(
          controller: studentController,
          onSaved: (String? value) {
            _studentName = value;
          },
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Student Name',
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
              return 'Student name is required';
            } else {
              _studentName = value;
            }
          },
        ));
  }

  Widget _build_assn_num(context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .25,
        alignment: Alignment.center,
        child: TextFormField(
          controller: assignmentController,
          onSaved: (String? value) {
            _assnNum = value;
          },
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Assignment Number',
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
              return 'Assignment Number is required';
            } else {
              _assnNum = value;
            }
          },
        ));
  }

  Widget _build_class_name(context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .25,
        alignment: Alignment.center,
        child: TextFormField(
          controller: classController,
          onSaved: (String? value) {
            _className = value;
          },
          style: const TextStyle(color: Colors.black54),
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black87),
              fillColor: Colors.purpleAccent,
              labelText: 'Class Name',
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
              return 'Class Name is required';
            } else {
              setState(() {
                _className = value;
              });
            }
          },
        ));
  }

  Widget _cpp_upload_button(context) {
    var size = MediaQuery.of(context).size;
    var width = size * .3;
    return ElevatedButton(
      onPressed: () {
        _pickCppFile();
      },
      child: Text('Choose Cpp file'),
      style: ElevatedButton.styleFrom(
        primary: Color(0xff862633),
        elevation: 3,
        minimumSize: Size(210, 40),
      ),
    );
  }

  Widget _input_builder_button(context) {
    return ElevatedButton(
      onPressed: () {
        _pickInputFile();
      },
      child: Text('Select Input File'),
      style: ElevatedButton.styleFrom(
        primary: Color(0xff862633),
        elevation: 3,
        minimumSize: Size(210, 40),
      ),
    );
  }

  Widget _submit_all_params(context) {
    return ElevatedButton(
      onPressed: sendRequest,
      child: Text('Begin Compilation'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        elevation: 3,
        minimumSize: Size(210, 40),
      ),
    );
  }

  void _pickCppFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['cpp', 'h', 'hpp']);
    if (result == null) return;
    PlatformFile file = result.files.single;
    if (result != null) {
      setState(() {
        _cppFile = File(result.files.single.path!);
        print(_cppFile);
        _files.add(_cppFile!);
      });
    }
  }

  void _pickInputFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['txt']);
    if (result == null) return;
    PlatformFile file = result.files.single;
    if (result != null) {
      setState(() {
        _inputFile = File(result.files.single.path!);
        print(result.files.single);
        print(_inputFile);
        _files.add(_inputFile!);
      });
    }
    // _inputFile = file;
    // _inputUri = file.path;
    // _inputName = file.name;
    // print('Input PATH IS:::::::::::::::::::::::::::::::');
    // print(_inputUri);
  }

  Future<String> sendRequest() async {
    _className = classController.text;
    _studentName = studentController.text;
    _assnNum = assignmentController.text;
    if (_className != null && _studentName != null && _assnNum != null) {
      var url =
          "http://157.245.141.117:8000/uploadfile?collection=$_className&assn_num=$_assnNum&student_name=$_studentName";
      var uri = Uri.parse(url);
      var formData = FormData();
      for (var file in _files) {
        print('BAD FILE ${file.path}');
        formData.files.addAll([
          MapEntry("file_list", await MultipartFile.fromFile(file.path)),
        ]);
      }
      var response = await dio.post(
        url,
        data: formData,
      );
      if (response.statusCode == 200) {
        final SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('map', response.data);
        Map<String, dynamic> jsonMap = json.decode(response.data);
        var comments = jsonMap['comments'][0]['file']['comments'];
        var total_lines = jsonMap['comments'][0]['file']['total_lines'];
        var commented_lines = jsonMap['comments'][0]['file']['lines'];
        var comment_percentage =
            jsonMap['comments'][0]['file']['comment_percentage'];

        var make_out = jsonMap['make']['stdout'];
        var make_return_code = jsonMap['make']['returncode'];
        var make_stderr = jsonMap['make']['stderr'];

        var results = jsonMap['results'];
        var stdout = jsonMap['stdout'];
        print(results);
        // Map<String, dynamic> jsonmap = json.decode(response.data);
        // Map<String, dynamic> jsonmap =d
        //     Map<String, dynamic>.from(json.decode(response.data));

        // var penis = jsonDecode(response.toString());
        // print('TYPE = ${penis.runtimeType}');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CompilationView()));
      }
    }

    return '';
  }
}
