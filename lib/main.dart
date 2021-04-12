import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/todo_catalogue.dart';

import './screens/map_screen.dart';
import './screens/todo_list_screen.dart';
import './screens/todo_add_catalogue_screen.dart';

void main() {
  // final gmapsApiKey = GMapsHelper().GMapsKey();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => TodoCatalogue())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: MapScreen(),
        routes: {
          ToDoListScreen.routeName: (ctx) => ToDoListScreen(),
          MapScreen.routeName: (ctx) => MapScreen(),
          ToDoAddCatalogueScreen.routeName: (ctx) => ToDoAddCatalogueScreen(),
          // TodoCatalogueDetailScreen.routeName: (ctx) =>
          //     TodoCatalogueDetailScreen(),
        },
      ),
    );
  }
}
