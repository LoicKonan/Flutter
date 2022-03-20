import 'dart:html';

import 'package:flutter/material.dart';
// /**AppBar(
//           backgroundColor: Colors.deepPurple,
//           title: Text("AgSoft"),
//           leading: GestureDetector(
//             onTap: () {/* Write listener code here */},
//             child: Icon(
//               Icons.menu, // add custom icons also
//             ),
//           ),
//           actions: <Widget>[
//             Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Icon(
//                     Icons.search,
//                     size: 26.0,
//                   ),
//                 )),
//             Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Icon(Icons.more_vert),
//                 )),
//           ],
//         ),************ */

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  const CustomAppBar({Key? key, this.backgroundColor, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              size: 26.0,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.more_vert),
            )),
      ],
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {/* Write listener code here */},
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
      title: Text(title as String),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
