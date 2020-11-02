import 'dart:convert';
import 'package:canteen_app/MenuScreen/menu_screen.dart';
import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/Models/returned_order.dart';
import 'package:canteen_app/OrderScreen/order_screen.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/functional/requests.dart';

import 'package:canteen_app/Models/category.dart';
import 'package:flutter/material.dart';

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
      showDialog(
          context: MenuScreen.menuScreenContext,
          builder: (BuildContext context) {
            return CustomAlertDialog(
                alertTitle: 'Произошла ошибка',
                alertText: "Ошибка подключения к серверу",
                buttons: <Widget>[
                  new FlatButton(
                    textColor: cleanOrderButtonColor,
                    child: new Text("ОК"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
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
    } catch (e) {
      showDialog(
          context: OrderScreen.orderScreenContext,
          builder: (BuildContext context) {
            return CustomAlertDialog(
                alertTitle: 'Произошла ошибка',
                alertText: "Ошибка подключения к серверу",
                buttons: <Widget>[
                  new FlatButton(
                    textColor: cleanOrderButtonColor,
                    child: new Text("ОК"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
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
      showDialog(
          context: OrderScreen.orderScreenContext,
          builder: (BuildContext context) {
            return CustomAlertDialog(
                alertTitle: 'Произошла ошибка',
                alertText: "Ошибка подключения к серверу",
                buttons: <Widget>[
                  new FlatButton(
                    textColor: cleanOrderButtonColor,
                    child: new Text("ОК"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
      print(e);
    }
  }
}
