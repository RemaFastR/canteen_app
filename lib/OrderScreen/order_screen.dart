import 'package:canteen_app/functional/attributes.dart';
import 'package:flutter/material.dart';

import '../SelectCategoryScreen/select_category_screen.dart';
import '../SelectCategoryScreen/select_category_screen.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

final List<Product> categories = [
  Product('Пюре', 'assets/images/categories/soup.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/garnish.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Пюре', 'assets/images/categories/meat.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/salad.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Пюре', 'assets/images/categories/cake.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/drink.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Пюре', 'assets/images/categories/cake.png', 30, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
  Product('Куриный суп', 'assets/images/categories/drink.png', 60, 40,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
];

var size;
double itemHeight;
double itemWidth;

class _OrderScreenState extends State<OrderScreen> {
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
        child: CreateOrderList(),
      ),
    );
  }
}

class CreateOrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    /*24 - notification bar на Android*/
    itemHeight = (size.height - kToolbarHeight - 24) / 2;
    itemWidth = size.width / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: orderListWidget(products)),
        Padding(
            padding: EdgeInsets.only(
                bottom: itemHeight / 60, left: 10, right: 10, top: 10),
            child: Container(
                height: 5,
                decoration: new BoxDecoration(
                  color: Theme.of(context).accentColor,
                ))),
        Container(
            padding: EdgeInsets.only(left: 10),
            child: Text('Итог: 150Р',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 25))),
        confirmWidget(context)
      ],
    );
  }

  Widget orderListWidget(List<Product> products) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(3),
              height: itemHeight / 4,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: cardsColor,
                  child: Center(
                    child: ListTile(
                      leading: Image.asset(products[index].image),
                      title: Text(
                        products[index].title,
                        style: TextStyle(color: titlesColor, fontSize: 25),
                      ),
                      subtitle: Text(
                        products[index].cost,
                        style: TextStyle(
                            color: orderProductCostColor, fontSize: 17),
                      ),
                    ),
                  )));
        });
  }

  Widget confirmWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 10, top: 10, left: 10),
            height: 60,
            width: 160,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              fillColor: createOrderButtonColor,
              splashColor: createOrderButtonColor,
              onPressed: () {
                showGeneralDialog(
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionBuilder: (context, a1, a2, widget) {
                      final curvedValue =
                          Curves.easeInOutBack.transform(a1.value) - 1.0;
                      return Transform(
                        transform: Matrix4.translationValues(
                            0.0, curvedValue * 200, 0.0),
                        child: Opacity(
                            opacity: a1.value,
                            child: CreateOrderDialog(
                                messageText:
                                    'Спасибо за ваш заказ! Он принят в обработку.',
                                orderNumTitle: 'Номер заказа',
                                orderNumber: '123')),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 200),
                    barrierDismissible: true,
                    barrierLabel: '',
                    context: context,
                    pageBuilder: (context, animation1, animation2) {});
              },
              child: Text(
                'Оформить',
                style: TextStyle(color: titlesColor, fontSize: 24),
              ),
            )),
        Container(
            padding: EdgeInsets.only(bottom: 10, top: 10, right: 10),
            height: 60,
            width: 160,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              fillColor: cleanOrderButtonColor,
              splashColor: cleanOrderButtonColor,
              onPressed: () {},
              child: Text(
                'Очистить',
                style: TextStyle(color: titlesColor, fontSize: 24),
              ),
            )),
      ],
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
            width: itemWidth + 50,
            padding: EdgeInsets.all(15),
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
