import 'package:canteen_app/main.dart';
import 'package:flutter/material.dart';

class Order {
  static double staticOrderPrice;
  List<ProductForOrder> orderList;

  Order() {
    orderList = orderProductsList;
  }

  Map<String, dynamic> toJson() => {
        'products': orderList,
      };

  static double getOrderPrice() {
    double orderPrice;
    for (var item in orderProductsList) {
      orderPrice += item.cost * item.quantity;
    }
    return orderPrice;
  }
}

class ProductForOrder {
  int id;
  int quantity;
  String title;
  String image;
  double cost;

  ProductForOrder(
      {@required this.id,
      @required this.quantity,
      this.title,
      this.image,
      this.cost});

  factory ProductForOrder.fromJson(Map<String, dynamic> json) {
    return ProductForOrder(id: json["id"], quantity: json["quantity"]);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };
}
