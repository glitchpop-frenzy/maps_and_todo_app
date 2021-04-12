import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/todo.dart';

class Api {
  String baseUrl = 'https://mapandtodo-default-rtdb.firebaseio.com';

  Future<Map<String, dynamic>> getCatalogues() async {
    final response = await http.get('$baseUrl/userCatalogues.json');
    return json.decode(response.body) as Map<String, dynamic>;
  }

  Future<String> addCatalogue(ToDo catalogue) async {
    String? title = catalogue.title;
    String? description = catalogue.description;
    String url = '$baseUrl/userCatalogues.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': title,
            'description': description,
          },
        ),
      );
      return json.decode(response.body)['name'];
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateCatalogue(String id, ToDo updatedCatalogue) async {
    String url = '$baseUrl/userCatalogues/$id.json';
    try {
      await http.patch(
        url,
        body: json.encode(
          {
            'title': updatedCatalogue.title,
            'description': updatedCatalogue.description,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<http.Response?> deleteCatalogue(String? id) async {
    String url = '$baseUrl/userCatalogues/$id.json';
    try {
      final response = http.delete(url);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
