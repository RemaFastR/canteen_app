import 'dart:convert';

import 'package:canteen_app/Models/product.dart';

class Category {
  int id;
  String title;
  List<Product> products;

  Category({this.id, this.title, this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    var list = json["products"] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();
    return Category(id: json["id"], title: json["name"], products: productList);
  }
}
