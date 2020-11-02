import 'dart:ui';

import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/OrderScreen/order_bloc.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/main.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);
  static BuildContext orderScreenContext;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    OrderScreen.orderScreenContext = context;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Заказ',
          style: TextStyle(color: productInfoColor),
        ),
      ),
      body: Container(
        child: CreateOrderList(),
      ),
    );
  }
}

class CreateOrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    orderBloc.getOrderList();
    orderBloc.getOrderPrice();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
            stream: orderBloc.orderStream,
            builder: (context, AsyncSnapshot<List<ProductForOrder>> snapshot) {
              if (snapshot.hasData) {
                print("Order Snapshot Size: ${snapshot.data.length}");
                return Expanded(child: OrderListWidget(snapshot.data));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Expanded(
                  child: Center(
                      child: Text(
                'Ваша корзина пустая',
                style: TextStyle(fontSize: 18),
              )));
            }),
        Padding(
            padding: EdgeInsets.only(
                bottom: ScreenSize.itemHeight / 60,
                left: 10,
                right: 10,
                top: 10),
            child: Container(
                height: 5,
                decoration: new BoxDecoration(
                  color: Theme.of(context).accentColor,
                ))),
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: StreamBuilder(
            stream: orderBloc.orderPriceStream,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              return Container(
                child: Text(
                    'Итог: ${snapshot.data ?? 0.toStringAsFixed(2)}' + '₽',
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 25)),
              );
            },
          ),
        ),
        StreamBuilder(
          stream: orderBloc.orderStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductForOrder>> snapshot) {
            return ConfirmWidget(
              orderPrice: Order.staticOrderPrice,
              products: snapshot.data,
            );
          },
        ),
      ],
    );
  }
}

class ConfirmWidget extends StatelessWidget {
  final double orderPrice;
  final List<ProductForOrder> products;

  ConfirmWidget({@required this.orderPrice, @required this.products});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
            height: 60,
            width: 160,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              fillColor: createOrderButtonColor,
              splashColor: createOrderButtonColor,
              onPressed: () {
                if (orderProductsList.length == 0) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                            alertTitle: 'Предупреждение',
                            alertText:
                                'Для совершения заказа заполните корзину',
                            buttons: <Widget>[
                              new FlatButton(
                                textColor: cleanOrderButtonColor,
                                child: new Text("Хорошо"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]);
                      });
                } else {
                  orderBloc.sendOrder(context, products);
                }
              },
              child: Text(
                'Оформить',
                style: TextStyle(color: titlesColor, fontSize: 24),
              ),
            )),
        Container(
            padding: const EdgeInsets.only(bottom: 10, top: 10, right: 10),
            height: 60,
            width: 160,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              fillColor: cleanOrderButtonColor,
              splashColor: cleanOrderButtonColor,
              onPressed: () {
                if (orderProductsList.length == 0) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                            alertTitle: 'Предупреждение',
                            alertText: 'Корзина уже пустая!',
                            buttons: <Widget>[
                              new FlatButton(
                                textColor: cleanOrderButtonColor,
                                child: new Text("Хорошо"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]);
                      });
                } else {
                  //orderBloc.getOrderById();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                            alertTitle: 'Предупреждение',
                            alertText:
                                'Вы действительно хотите очистить корзину?',
                            buttons: <Widget>[
                              new FlatButton(
                                textColor: cleanOrderButtonColor,
                                child: new Text("Да"),
                                onPressed: () {
                                  orderBloc.clearOrderList();
                                  Navigator.of(context).pop();
                                },
                              ),
                              new FlatButton(
                                textColor: cleanOrderButtonColor,
                                child: new Text("Нет"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]);
                      });
                }
              },
              child: Text(
                'Очистить',
                style: TextStyle(color: titlesColor, fontSize: 24),
              ),
            )),
      ],
    );
  }
}

class OrderListWidget extends StatelessWidget {
  List<ProductForOrder> products;
  OrderListWidget(this.products);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
              padding: const EdgeInsets.all(3),
              height: ScreenSize.itemHeight / 2.8,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: cardsColor,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: ScreenSize.itemHeight / 2,
                          child: Image.network(products[index].image +
                              '?CANTEEN-API-KEY=733fb9c1-db7f-4c0f-9cc0-59877c6cd8cf'),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                products[index].title ?? "",
                                style:
                                    TextStyle(color: titlesColor, fontSize: 21),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    products[index].cost.toStringAsFixed(2) +
                                            '₽' ??
                                        "",
                                    style: TextStyle(
                                        color: orderProductCostColor,
                                        fontSize: 18),
                                  ),
                                  StreamBuilder(
                                    stream: orderBloc.orderCountStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      return Row(
                                        children: [
                                          CustomCounter(
                                              icon: Icon(Icons.remove),
                                              onPress: () => orderBloc
                                                  .decrementProductCount(
                                                      products[index])),
                                          Text(
                                            products[index].quantity.toString(),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          CustomCounter(
                                              icon: Icon(Icons.add),
                                              onPress: () => orderBloc
                                                  .incrementProductCount(
                                                      products[index])),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )));
        });
  }
}

class CustomCounter extends StatelessWidget {
  final Icon icon;
  final Function onPress;

  CustomCounter({@required this.icon, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        constraints: BoxConstraints.tightFor(width: 30, height: 30),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30 * 0.2)),
        fillColor: Color(0xFF65A34A),
        onPressed: onPress,
        child: icon,
      ),
    );
  }
}

class CreateOrderDialog extends StatelessWidget {
  final String messageText, orderNumTitle, orderNumber;

  CreateOrderDialog({
    @required this.messageText,
    @required this.orderNumTitle,
    @required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: titlesColor,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: ScreenSize.itemWidth + 50,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  messageText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: productInfoColor, fontSize: 18),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderNumTitle,
                      style: TextStyle(color: barsColor, fontSize: 18),
                    ),
                    Text(orderNumber,
                        style: TextStyle(
                            color: orderProductCostColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: orderProductCostColor,
                  child: Icon(Icons.close, color: titlesColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
