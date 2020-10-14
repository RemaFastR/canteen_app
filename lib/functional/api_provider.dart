import 'dart:convert';
import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/Models/returned_order.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/functional/requests.dart';

import 'package:canteen_app/Models/category.dart';

class ApiProvider {
  final String url = "https://178.64.252.91:44304/api";

  Future<List<Category>> getCategories() async {
    List<Category> categories;

    String responseResult = await Requests.getRequest(
        '$url/menu?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf');
    var data = json.decode(responseResult);
    var rest = data as List;
    categories = rest.map<Category>((json) => Category.fromJson(json)).toList();
    return categories;
  }

  Future<List<Product>> getProductsFromCategory(int id) async {
    Category category;
    for (var cat in StaticVariables.staticCategories) {
      if (cat.id == id) category = cat;
    }
    List<Product> products = category.products;
    return products;
  }

  Future<int> createOrder() async {
    String responseBody = await Requests.postRequest(
        new Order(), 'https://178.64.252.91:44304/api/orders');
    ReturnedOrder returnedOrder =
        ReturnedOrder.fromJson(jsonDecode(responseBody));

    return returnedOrder.id;
  }
}
