import 'package:flutter/material.dart';

import '../screens/map_screen.dart';
import '../screens/todo_list_screen.dart';

class AppDrawer extends StatelessWidget {
  final String screen;
  AppDrawer(this.screen);

  bool _mapScr = false, _todoScr = false;

  @override
  Widget build(BuildContext context) {
    screen == 'map' ? _mapScr = true : _todoScr = true;
    final mediaQuery = MediaQuery.of(context);
    return Drawer(
      child: Container(
        child: Column(
          children: [
            AppBar(
              toolbarHeight: mediaQuery.size.height * 0.3,
              leading: Icon(
                Icons.dashboard_outlined,
                size: 50,
              ),
              title: Text(
                'Map, ToDo List',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.02,
            ),
            ListTile(
              onTap: () {
                if (screen != 'map') {
                  Navigator.of(context)
                      .pushReplacementNamed(MapScreen.routeName);
                } else {
                  Navigator.of(context).pop();
                }
              },
              selected: _mapScr,
              selectedTileColor: Color(0xFFffe5d9),
              leading: Icon(Icons.map_outlined),
              title: Text('Map Shutter'),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.02,
            ),
            ListTile(
              onTap: () {
                if (screen != 'todo') {
                  Navigator.of(context)
                      .pushReplacementNamed(ToDoListScreen.routeName);
                } else {
                  Navigator.of(context).pop();
                }
              },
              selected: _todoScr,
              selectedTileColor: Color(0xFFffe5d9),
              leading: Icon(Icons.note_add_outlined),
              title: Text('ToDo Catalogue'),
            )
          ],
        ),
      ),
    );
  }
}
