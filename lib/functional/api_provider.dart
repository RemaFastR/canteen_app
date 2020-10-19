import 'dart:convert';
import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/Models/returned_order.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/functional/requests.dart';

import 'package:canteen_app/Models/category.dart';

class ApiProvider {
  final String url = "https://canteen-chsu.ru/api";

  Future<List<Category>> getCategories() async {
    try {
      List<Category> categories;

      String responseResult = await Requests.getRequest(
          '$url/menu?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf');
      var data = json.decode(responseResult);
      var rest = data as List;
      categories =
          rest.map<Category>((json) => Category.fromJson(json)).toList();
      return categories;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Product>> getProductsFromCategory(int id) async {
    Category category;
    for (var cat in StaticVariables.staticCategories) {
      if (cat.id == id) category = cat;
    }
    List<Product> products = category.products;
    return products;
  }

  Future<String> getOrderById(int id) async {
    try {
      return await Requests.getRequest('$url/orders/$id' +
          '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf');
      // ReturnedOrder returnedOrder =
      //     ReturnedOrder.fromJson(jsonDecode(responseBody));
    } catch (e) {
      print(e);
    }
  }

  Future<int> createOrder() async {
    try {
      String responseBody =
          await Requests.postRequest(new Order(), '$url/orders');
      ReturnedOrder returnedOrder =
          ReturnedOrder.fromJson(jsonDecode(responseBody));

      return returnedOrder.id;
    } catch (e) {
      print(e);
    }
  }
}
