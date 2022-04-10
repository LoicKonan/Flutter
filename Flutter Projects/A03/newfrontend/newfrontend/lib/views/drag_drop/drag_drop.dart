import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file/file.dart';

class DragFile extends StatefulWidget {
  DragFile({Key? key}) : super(key: key);

  @override
  State<DragFile> createState() => _DragFileState();
}

class _DragFileState extends State<DragFile> {
  final Set<dynamic> files = {};
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
            padding: EdgeInsets.all(50.0),
            child: Column(
              children: [
                DropTarget(
                  onDragDone: (urls) async {
                    setState(() {
                      files.addAll(urls.files);
                    });
                    print(files);
                  },
                  child: Container(
                    color: Colors.blue,
                    height: 200,
                    child: Center(
                      child: Text(
                        'Drag & Drop files',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // buildFiles(),
              ],
            )));
  }

  // Widget buildFiles() => SingleChildScrollView(
  //       child: Column(
  //         children: files.map(buildFile).toList(),
  //       ),
  //     );

  // Widget buildFile(Uri file) {
  //   return ListTile(
  //     leading: Container(
  //       width: 60,
  //       child: Icon(Icons.text_snippet, size: 40, color: Colors.green),
  //     ),
  //     title: Text(file.path),
  //   );
  // }
}
