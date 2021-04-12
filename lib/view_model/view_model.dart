import 'package:http/http.dart' as http;

import '../providers/todo.dart';
import '../model/api.dart';

class ViewModel {
  Future<String> addCatalogue(ToDo catalogue) async {
    final id = await Api().addCatalogue(catalogue);
    return id;
  }

  Future<void> updateCatalogue(String id, ToDo updatedCatalogue) async {
    await Api().updateCatalogue(id, updatedCatalogue);
  }

  Future<Map<String, dynamic>> getCatalogues() async {
    final Map<String, dynamic> response = await Api().getCatalogues();
    return response;
  }

  Future<http.Response?> deleteCatalogue(String id) async {
    final response = await Api().deleteCatalogue(id);
    return response;
  }
}
