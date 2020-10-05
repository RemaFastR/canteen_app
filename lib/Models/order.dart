import 'package:canteen_app/main.dart';
import 'package:flutter/material.dart';

class Order {
  static int staticOrderPrice;
  List<ProductForOrder> orderList;

  Order() {
    orderList = orderProductsList;
  }

  Map<String, dynamic> toJson() => {
        'products': orderList,
      };

  static int getOrderPrice() {
    int orderPrice;
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
  int cost;

  ProductForOrder(
      {@required this.id,
      @required this.quantity,
      this.title,
      this.image,
      this.cost});

  // ProductForOrder.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };
}
