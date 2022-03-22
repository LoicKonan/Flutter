import 'package:agsoft/components/app_bar.dart';
import 'package:agsoft/views/card_views/card_view.dart';
import 'package:flutter/material.dart';

// This is the class that will handle the HomeScreen
// It will set the color and the different widgets that
// will be displayed on the screen.
class HomeScreen extends StatelessWidget {
  // Generate some dummy data
  final List<Map<String, dynamic>> _items = List.generate(
      4,
      (index) => {
            "id": index,
            "title": "Class $index",
            "subtitle": "Subtitle $index"
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: CustomAppBar(
            backgroundColor: Colors.deepPurple,
            title: 'Agsoft',
          ),
        ),
        body: ListTileTheme(
          contentPadding: EdgeInsets.all(15),
          iconColor: Colors.red,
          textColor: Colors.black54,
          tileColor: const Color(0xFFf5e78c),
          style: ListTileStyle.list,
          dense: true,
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              margin: EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                title: Text(_items[index]['title']),
                subtitle: Text(_items[index]['subtitle']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CardWidgetView()));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
