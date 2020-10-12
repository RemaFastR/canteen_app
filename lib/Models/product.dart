import 'package:flutter/cupertino.dart';

class Product {
  int id;
  String image;
  String title;
  double cost;
  int grammar;
  String composition;
  String description;
  int categoryId;

  Product({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.cost,
    @required this.grammar,
    @required this.composition,
    @required this.description,
    this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        cost: json["price"],
        grammar: json["weight"],
        composition: json["composition"],
        description: json["description"],
        categoryId: json["categoryId"]);
  }

  @override
  String toString() {
    return 'Product(image: $image, title: $title, cost: $cost, grammar: $grammar, composition: $composition, description: $description, categoryId: $categoryId)';
  }
}
