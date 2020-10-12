import 'dart:convert';
import 'dart:io';

import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/returned_order.dart';
import 'package:canteen_app/OrderScreen/check_screen.dart';
import 'package:canteen_app/OrderScreen/order_screen.dart';
import 'package:canteen_app/functional/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class OrderBloc implements Bloc {
  //SelectCategoryRepository _categoryRepository = SelectCategoryRepository();

  final _orderFetcher = PublishSubject<List<ProductForOrder>>();
  final _orderPriceFetcher = PublishSubject<double>();
  final _orderCountFetcher = PublishSubject<int>();

  Observable<List<ProductForOrder>> get orderStream => _orderFetcher.stream;
  Observable<double> get orderPriceStream => _orderPriceFetcher.stream;
  Observable<int> get orderCountStream => _orderCountFetcher.stream;

  getOrderList() async {
    List<ProductForOrder> orders = orderProductsList;
    _orderFetcher.sink.add(orders);
  }

  clearOrderList() async {
    orderProductsList.clear();
    double orderPrice = 0;
    List<ProductForOrder> orders = orderProductsList;
    _orderFetcher.sink.add(orders);
    _orderPriceFetcher.sink.add(orderPrice);
  }

  double orderPrice = 0;
  getOrderPrice() async {
    orderPrice = 0;
    for (var item in orderProductsList) {
      orderPrice += item.cost * item.quantity;
    }
    Order.staticOrderPrice = orderPrice;
    _orderPriceFetcher.sink.add(orderPrice);
  }

  getProductCount(ProductForOrder productForOrder) async {
    _orderCountFetcher.sink.add(productForOrder.quantity);
  }

  incrementProductCount(ProductForOrder productForOrder) async {
    productForOrder.quantity++;
    print("product ${productForOrder.title} count ${productForOrder.quantity}");
    _orderCountFetcher.sink.add(productForOrder.quantity);
    getOrderPrice();
  }

  decrementProductCount(ProductForOrder productForOrder) async {
    productForOrder.quantity--;
    print("product ${productForOrder.title} count ${productForOrder.quantity}");
    if (productForOrder.quantity > 0) {
      _orderCountFetcher.sink.add(productForOrder.quantity);
      getOrderPrice();
    } else {
      //productForOrder.quantity = 1;
      print("product count < 1");
      orderProductsList.remove(productForOrder);
      List<ProductForOrder> orders = orderProductsList;
      _orderFetcher.sink.add(orders);
      getOrderPrice();
    }
  }

  sendOrder(BuildContext context, List<ProductForOrder> products) async {
    if (orderProductsList.length == 0)
      print("Ваша корзина пустая!");
    else {
      int orderNum = await createOrder();
      goToCheck(context, orderNum, products);
      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                  opacity: a1.value,
                  child: CreateOrderDialog(
                      messageText:
                          'Спасибо за ваш заказ! Он принят в обработку.',
                      orderNumTitle: 'Номер заказа',
                      orderNumber: orderNum.toString())),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {});
    }
  }

  Future<int> createOrder() async {
    try {
      final http.Response response = await http.post(
        'https://178.64.252.91:44304/api/orders',
        headers: {
          "Content-Type": "application/json",
          'CANTEEN-API-KEY': '733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf'
        },
        body: jsonEncode(new Order()),
      );
      if (response.statusCode == 201) {
        print(jsonDecode(response.body));
        ReturnedOrder returnedOrder =
            ReturnedOrder.fromJson(jsonDecode(response.body));

        return returnedOrder.id;
      } else {
        throw Exception('Ошибка при отправке заказа');
      }
    } catch (e) {
      print(e);
    }
  }

  goToCheck(BuildContext context, int orderServerNumber,
      List<ProductForOrder> products) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateOrderScreen(
                  productsInCheck: products,
                  orderPrice: orderPrice,
                  orderServerNumber: orderServerNumber,
                )));
  }

  @override
  void dispose() {
    _orderFetcher.close();
    _orderPriceFetcher.close();
    _orderCountFetcher.close();
  }
}

final orderBloc = OrderBloc();
