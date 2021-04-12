import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo.dart';
import '../providers/todo_catalogue.dart';
import '../screens/todo_add_catalogue_screen.dart';

enum ops { Edit, Delete }

class TodoItem extends StatefulWidget {
  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  String? catId;
  bool _isLoading = false;

  Widget _popUp(String? catId) {
    return PopupMenuButton(
        onSelected: operation,
        icon: Icon(Icons.more_vert_sharp),
        itemBuilder: (ctx) {
          return <PopupMenuEntry<ops>>[
            PopupMenuItem(
              child: Text('Edit'),
              value: ops.Edit,
            ),
            PopupMenuItem(
              child: Text('Delete'),
              value: ops.Delete,
            )
          ];
        });
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 5),
        behavior: SnackBarBehavior.floating,
        content: SizedBox(
            height: 20,
            child: FittedBox(
              child: Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            )),
        duration: Duration(seconds: 4),
      ),
    );
  }

  BuildContext? ctx;

  void _deleteCatalogue(String? id) async {
    setState(() {
      _isLoading = true;
    });
    final response = await Provider.of<TodoCatalogue>(context, listen: false)
        .deleteCatalogue(id!);

    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
    response.statusCode < 400
        ? showSnackBar('Catalogue Deleted Successfully!!')
        : showSnackBar('Deletion Failed!!');
  }

  void operation(ops option) {
    option == ops.Edit
        ? Navigator.of(ctx!)
            .pushNamed(ToDoAddCatalogueScreen.routeName, arguments: catId)
        : _deleteCatalogue(catId);
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final mediaQuery = MediaQuery.of(context);

    final catalogue = Provider.of<ToDo>(context, listen: false);
    catId = catalogue.id;
    return Container(
      margin: EdgeInsets.all(5),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                    ToDoAddCatalogueScreen.routeName,
                    arguments: catalogue.id);
              },
              splashColor: Colors.grey[300],
              child: GestureDetector(
                child: GridTile(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mediaQuery.size.width * 0.30,
                              child: LayoutBuilder(
                                builder: (context, constraints) => Text(
                                  '${catalogue.title}',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            _popUp(catalogue.id),
                          ]),
                      Divider(
                        color: Colors.blueGrey,
                        height: 0.5,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 1.5, left: 3, right: 1.25, bottom: 0.9),
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${catalogue.description}',
                          softWrap: true,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
