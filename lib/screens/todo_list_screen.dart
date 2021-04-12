import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_catalogue.dart';

import 'todo_add_catalogue_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/todo_grid.dart';

class ToDoListScreen extends StatefulWidget {
  static const routeName = '/todo-list-screen';

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TodoCatalogue>(context).getCatalogues().then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Color(0xFFfff1e6),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('ToDo Catalogues'),
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(ToDoAddCatalogueScreen.routeName),
                  icon: Icon(Icons.add_sharp),
                )
              ],
            ),
            body: TodoGrid(),
            drawer: AppDrawer('todo'),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(ToDoAddCatalogueScreen.routeName),
              child: Icon(Icons.add_sharp),
            ),
          );
  }
}
