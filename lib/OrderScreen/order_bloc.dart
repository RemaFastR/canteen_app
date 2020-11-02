import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/returned_order.dart';
import 'package:canteen_app/OrderScreen/check_screen.dart';
import 'package:canteen_app/OrderScreen/order_repos.dart';
import 'package:canteen_app/OrderScreen/order_screen.dart';
import 'package:canteen_app/functional/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

class OrderBloc implements Bloc {
  OrderRepository _orderRepository = OrderRepository();

  final _orderFetcher = PublishSubject<List<ProductForOrder>>();
  final _orderPriceFetcher = PublishSubject<double>();
  final _orderCountFetcher = PublishSubject<int>();
  final _orderStatusFetcher = PublishSubject<String>();

  Observable<List<ProductForOrder>> get orderStream => _orderFetcher.stream;
  Observable<double> get orderPriceStream => _orderPriceFetcher.stream;
  Observable<int> get orderCountStream => _orderCountFetcher.stream;
  Observable<String> get orderStatusStream => _orderStatusFetcher.stream;

  static bool orderIsCreated = false;
  static Timer timer;

  getOrderList() async {
    _orderFetcher.sink.add(orderProductsList);
  }

  clearOrderList() async {
    orderProductsList.clear();
    _orderFetcher.sink.add(orderProductsList);
    _orderPriceFetcher.sink.add(0);
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
    _orderCountFetcher.sink.add(productForOrder.quantity);
    getOrderPrice();
  }

  decrementProductCount(ProductForOrder productForOrder) async {
    productForOrder.quantity--;
    if (productForOrder.quantity > 0) {
      _orderCountFetcher.sink.add(productForOrder.quantity);
      getOrderPrice();
    } else {
      orderProductsList.remove(productForOrder);
      _orderFetcher.sink.add(orderProductsList);
      getOrderPrice();
    }
  }

  int orderNum;
  sendOrder(BuildContext context, List<ProductForOrder> products) async {
    orderIsCreated = true;
    if (orderProductsList.length == 0)
      print("Ваша корзина пустая!");
    else {
      orderNum = await _orderRepository.createOrder();
      print('Order Id $orderNum is saved on cache');
      goToCheck(context, orderNum, products);
      showCheckDialog(context, orderNum);
    }
  }

  getOrderById(BuildContext context) async {
    if (orderNum != 0) {
      String orderInfo = await _orderRepository.getOrderById(orderNum);
      print(orderInfo);
      ReturnedOrder returnedOrder;
      Map orderMap = jsonDecode(orderInfo);
      returnedOrder = ReturnedOrder.fromJson(orderMap);
      print(returnedOrder);
      switch (returnedOrder.currentState) {
        case 0:
          _orderStatusFetcher.sink.add('Создан');
          break;
        case 1:
          _orderStatusFetcher.sink.add('Готовится');
          break;
        case 2:
          _orderStatusFetcher.sink.add('Готов');
          break;
        case 3:
          timer.cancel();
          orderProductsList.clear();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OrderScreen()));
          break;
        default:
          _orderStatusFetcher.sink.add('Неизвестно');
      }
    } else
      print('Order Id is empty');
  }

  getOrderStatus(BuildContext context) async {
    timer = Timer.periodic(Duration(seconds: 5), (_) => getOrderById(context));
  }

  showCheckDialog(BuildContext context, int orderNum) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
                opacity: a1.value,
                child: CreateOrderDialog(
                    messageText: 'Спасибо за ваш заказ! Он принят в обработку.',
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
    _orderStatusFetcher.close();
  }
}

final orderBloc = OrderBloc();

enum OrderState { Created, Processing, Completed }
