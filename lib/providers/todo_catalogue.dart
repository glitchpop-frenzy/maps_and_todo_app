import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:provider/provider.dart';
import 'todo.dart';

import '../view_model/view_model.dart';

class TodoCatalogue extends ChangeNotifier {
  List<ToDo> _catalogues = [];

  List<ToDo> get catalogues {
    return [..._catalogues];
  }

  Future<void> getCatalogues() async {
    List<ToDo> loadedCatalogues = [];
    final extractedCatalogues = await ViewModel().getCatalogues();
    if (extractedCatalogues != null) {
      extractedCatalogues.forEach(
        (catId, catData) {
          loadedCatalogues.add(ToDo(
              id: catId,
              title: catData['title'],
              description: catData['description']));
        },
      );
    }

    _catalogues = loadedCatalogues;
    notifyListeners();
  }

  ToDo findById(String id) {
    return _catalogues.firstWhere((catalogue) => catalogue.id == id);
  }

  Future<void> addCatalogue(ToDo newCat) async {
    ToDo newToDo = newCat;
    final catId = await ViewModel().addCatalogue(newToDo);
    newToDo.id = catId;
    _catalogues.add(newToDo);
    notifyListeners();
  }

  Future<void> updateCatalogue(String id, ToDo updatedCat) async {
    final _catalogueIndex = _catalogues.indexWhere((catId) => catId.id == id);
    await ViewModel().updateCatalogue(id, updatedCat);
    _catalogues[_catalogueIndex] = updatedCat;
    notifyListeners();
  }

  Future<http.Response> deleteCatalogue(String id) async {
    int? _catalogueIndex = _catalogues.indexWhere((catId) => catId.id == id);
    final _catalogueData = _catalogues[_catalogueIndex];
    http.Response? response = await ViewModel().deleteCatalogue(id);
    _catalogues.removeAt(_catalogueIndex);
    print(response?.statusCode);
    if (response!.statusCode >= 400) {
      _catalogues.insert(_catalogueIndex, _catalogueData);
      notifyListeners();
    } else {
      _catalogueIndex = null;
    }
    notifyListeners();
    return response;
  }
}
