import 'dart:ui';

import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/OrderScreen/order_bloc.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CreateOrderScreen extends StatefulWidget {
  final int orderServerNumber;
  double orderPrice;
  final List<ProductForOrder> productsInCheck;
  CreateOrderScreen(
      {Key key,
      @required this.orderServerNumber,
      @required this.orderPrice,
      @required this.productsInCheck})
      : super(key: key);

  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState(
      orderServerNumber: orderServerNumber,
      orderPrice: orderPrice,
      productsInCheck: productsInCheck);
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final int orderServerNumber;
  double orderPrice;
  final List<ProductForOrder> productsInCheck;
  _CreateOrderScreenState(
      {@required this.orderServerNumber,
      @required this.orderPrice,
      @required this.productsInCheck});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Заказ',
          style: TextStyle(color: productInfoColor),
        ),
      ),
      body: Container(
        child: CheckScreen(
          productsInCheck: productsInCheck,
          orderPrice: orderPrice,
          orderServerNumber: orderServerNumber,
        ),
      ),
    );
  }
}

const orderInfoTextColor = Color.fromRGBO(156, 137, 126, 1);
const orderTitleTextColor = Color.fromRGBO(64, 55, 55, 1);
const totalLabelTextColor = Color.fromRGBO(164, 74, 63, 1);

class CheckScreen extends StatelessWidget {
  final int orderServerNumber;
  double orderPrice;
  final List<ProductForOrder> productsInCheck;

  CheckScreen(
      {@required this.orderServerNumber,
      @required this.orderPrice,
      @required this.productsInCheck});

  @override
  Widget build(BuildContext context) {
    orderBloc.getOrderPrice();
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Информация о заказе',
              style: TextStyle(
                  color: orderInfoTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(228, 230, 195, 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Номер заказа:',
                              style: TextStyle(
                                  color: orderTitleTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              orderServerNumber.toString(),
                              style: TextStyle(
                                  color: orderTitleTextColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        DividingLine(),
                        Expanded(
                          child: ProductsInCheckList(
                              productsInCheck: productsInCheck),
                        ),
                        DividingLine(),
                        Row(
                          children: [
                            Text(
                              'Итог: ',
                              style: TextStyle(
                                  color: totalLabelTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              orderPrice.toStringAsFixed(2) + '₽',
                              style: TextStyle(
                                  color: totalLabelTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}

class DividingLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: ScreenSize.itemHeight / 60,
        ),
        child: Container(
            height: 5,
            decoration: new BoxDecoration(
              color: Theme.of(context).accentColor,
            )));
  }
}

class ProductsInCheckList extends StatelessWidget {
  final List<ProductForOrder> productsInCheck;

  ProductsInCheckList({@required this.productsInCheck});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(228, 230, 195, 0.5),
      child: ListView.builder(
          itemCount: productsInCheck.length,
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.all(3),
                height: ScreenSize.itemHeight / 2.8,
                child: Container(
                    color: Color.fromRGBO(228, 230, 195, 0.4),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          //Image.asset(productsInCheck[index].image) ?? "",
                          Image.network(productsInCheck[index].image +
                              '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf'),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  productsInCheck[index].title ?? "",
                                  style: TextStyle(
                                      color: orderTitleTextColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Количество: ',
                                      style: TextStyle(
                                          color: orderTitleTextColor,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      productsInCheck[index]
                                              .quantity
                                              .toString() ??
                                          "",
                                      style: TextStyle(
                                          color: orderTitleTextColor,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (productsInCheck[index].cost *
                                                      productsInCheck[index]
                                                          .quantity)
                                                  .toStringAsFixed(2) +
                                              '₽' ??
                                          "",
                                      style: TextStyle(
                                          color: orderProductCostColor,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    )));
          }),
    );
  }
}
