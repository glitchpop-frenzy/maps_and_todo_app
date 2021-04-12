import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_catalogue.dart';
import '../providers/todo.dart';
import 'todo_item.dart';

class TodoGrid extends StatefulWidget {
  @override
  _TodoGridState createState() => _TodoGridState();
}

class _TodoGridState extends State<TodoGrid> {
  @override
  Widget build(BuildContext context) {
    List<ToDo> catalogues = Provider.of<TodoCatalogue>(context).catalogues;

    return catalogues.length == 0
        ? Container(
            decoration: BoxDecoration(color: Color(0xFFfff1e6)),
            child: Center(
              child: Text(
                'No ToDo Jotting - Start adding some!!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        : Ink(
            decoration: BoxDecoration(color: Color(0xFFfff1e6)),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                // mainAxisSpacing: 10,
                // crossAxisSpacing: 7,
              ),
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider<ToDo>.value(
                  value: catalogues[index],
                  child: TodoItem(),
                );
              },
              itemCount: catalogues.length,
            ),
          );
  }
}
