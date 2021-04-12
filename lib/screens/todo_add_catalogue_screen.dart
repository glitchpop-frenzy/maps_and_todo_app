import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo.dart';
import '../providers/todo_catalogue.dart';

class ToDoAddCatalogueScreen extends StatefulWidget {
  static const routeName = '/todo-add-catalogue';
  @override
  _ToDoAddCatalogueScreenState createState() => _ToDoAddCatalogueScreenState();
}

class _ToDoAddCatalogueScreenState extends State<ToDoAddCatalogueScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desriptionController = TextEditingController();
  FocusNode _titleNode = FocusNode();
  FocusNode _desciptionNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleNode.dispose();
    _desciptionNode.dispose();
    _titleController.dispose();
    _desriptionController.dispose();
    super.dispose();
  }

  String? id;

  bool _isInit = true;
  ToDo? loadedCatalogue;

  void _submit([String? id]) async {
    final _isValid = _formKey.currentState?.validate();
    if (!_isValid!) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });
    ToDo newCat = ToDo(
        title: _titleController.text,
        description: _desriptionController.text,
        id: id);

    id == null
        ? await Provider.of<TodoCatalogue>(context, listen: false)
            .addCatalogue(newCat)
        : await Provider.of<TodoCatalogue>(context, listen: false)
            .updateCatalogue(id, newCat);

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      id = ModalRoute.of(context)?.settings.arguments as String;
      if (id != null) {
        loadedCatalogue = Provider.of<TodoCatalogue>(context).findById(id!);
        _titleController.text = loadedCatalogue!.title!;
        _desriptionController.text = loadedCatalogue!.description!;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Color(0xFFf8edeb),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Add a ToDo'),
              actions: [
                IconButton(
                  onPressed: () => {id == '' ? _submit : _submit(id)},
                  icon: Icon(
                    Icons.check_sharp,
                  ),
                )
              ],
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    focusNode: _titleNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_desciptionNode);
                    },
                    validator: (value) {
                      if (value == '') {
                        return 'Title cannot be null';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    controller: _desriptionController,
                    maxLines: 18,
                    minLines: 1,
                    focusNode: _desciptionNode,
                    textInputAction: TextInputAction.newline,
                  ),
                ],
              ),
            ),
          );
  }
}
