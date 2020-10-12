import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:canteen_app/Models/category.dart';

class ApiProvider {
  final String url = "https://178.64.252.91:44304/api";

  Future<List<Category>> getCategories() async {
    List<Category> categories;
    var res = await http
        .get('$url/menu?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf');
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      print(rest);
      categories =
          rest.map<Category>((json) => Category.fromJson(json)).toList();
      return categories;
    } else {
      throw Exception('Ошибка при загрузке категорий');
    }
  }
}
