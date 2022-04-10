import 'dart:io';

import 'package:agsoft2/components/app_bar.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadFiles extends StatefulWidget {
  UploadFiles({Key? key}) : super(key: key);

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  PlatformFile? _cppFile;
  PlatformFile? _inputFile;
  String? _cppFileName;
  String? _inputFileName;
  String? _cppUri;
  String? _inputUri;
  String? _className;
  String? _studentName;
  String? _assnNum;
  String? _inputName;
  String? _cppName;
  Dio dio = Dio();
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
              _className = value;
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
      onPressed: updateImage,
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
    _cppUri = file.path;
    _cppName = file.name;
    _cppFile = file;
    print('FILE PATH IS:::::::::::::::::::::::::::::::');
    print(_cppUri);
  }

  void _pickInputFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['txt']);
    if (result == null) return;
    PlatformFile file = result.files.single;
    _inputUri = file.path;
    _inputName = file.name;
    print('Input PATH IS:::::::::::::::::::::::::::::::');
    print(_inputUri);
  }

  void updateImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    print(token);
  }

  Future sendRequest() async {
    _className = classController.text;
    _studentName = studentController.text;
    _assnNum = assignmentController.text;
    if (_inputUri != null && _cppUri != null) {
      print('Values passed null check');
      List<io.File> file_list;

      var cppFile = io.File(_cppUri as String);
      var inputFile = io.File(_inputUri as String);
      var url =
          "http://157.245.141.117:8000/uploadfile?collection=$_className&assn_num=$_assnNum&student_name=$_studentName/";
      var uri = Uri.parse(url);
      print(_cppName);
      print(_inputName);
      http.MultipartRequest request = new http.MultipartRequest('Post', uri);
      request.files
          .add(await http.MultipartFile.fromPath(_inputName!, _inputUri!));
      request.files.add(await http.MultipartFile.fromPath(_cppName!, _cppUri!));
      final result = http.Response.fromStream(await request.send());
      print(result);
    }
  }
}
