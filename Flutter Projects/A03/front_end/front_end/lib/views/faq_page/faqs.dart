import 'package:flutter/material.dart';

class FAQS extends StatelessWidget {
  const FAQS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0d578),
      appBar: AppBar(
        backgroundColor: Color(0xff862633),
        title: const Text('FAQs'),
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
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: const [
                Text(
                  'Password Requirements',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                    'Passwords must contain an uppercase letter, a number, and a special character',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'How do I add a new class?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'At the moment, class creation is handled in the backend automatically. In future releases, this will change allowing users further flexibillity and customization. This will allow AGsoft to behave as a complete grade/storage platform.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Where is the program grade?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'AGsoft is an assisted grading platform. Final grading relies upon human decision making.  AGsoft is built to provide code insight allowing graders a more complete view while saving valuable time.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            )),
      ),
    );
  }
}
