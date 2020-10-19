import 'dart:convert';

import 'package:http/http.dart' as http;

class Requests {
  static Future<String> getRequest(String route) async {
    var response = await http.get(route);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Ошибка при загрузке данных');
    }
  }

  static Future postRequest(Object object, String route) async {
    try {
      var response = await http.post(
        route,
        headers: {
          "Content-Type": "application/json",
          'CANTEEN-API-KEY': '733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf'
        },
        body: jsonEncode(object),
      );
      if (response.statusCode == 201) {
        return response.body;
      } else {
        throw Exception('Ошибка при создании заказа');
      }
    } catch (e) {
      print(e);
    }
  }
}
