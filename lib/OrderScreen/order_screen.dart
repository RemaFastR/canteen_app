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
          style: TextStyle(color: Color.fromRGBO(64, 55, 55, 1)),
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
        confirmWidget()
      ],
    );
  }

  Widget orderListWidget(List<Product> products) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
              height: itemHeight / 3,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color.fromRGBO(166, 192, 133, 1),
                child: ListTile(
                  leading: Image.asset(products[index].image),
                  title: Text(
                    products[index].title,
                    style: TextStyle(
                        color: Color.fromRGBO(251, 244, 244, 1), fontSize: 25),
                  ),
                  subtitle: Text(
                    products[index].cost,
                    style: TextStyle(
                        color: Color.fromRGBO(164, 74, 63, 1), fontSize: 17),
                  ),
                ),
              ));
        });
  }

  Widget confirmWidget() {
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
              fillColor: Color.fromRGBO(248, 144, 144, 1),
              splashColor: Color.fromRGBO(248, 144, 144, 1),
              onPressed: () {},
              child: Text(
                'Оформить',
                style: TextStyle(
                    color: Color.fromRGBO(251, 244, 244, 1), fontSize: 24),
              ),
            )),
        Container(
            padding: EdgeInsets.only(bottom: 10, top: 10, right: 10),
            height: 60,
            width: 160,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              fillColor: Color.fromRGBO(199, 86, 72, 1),
              splashColor: Color.fromRGBO(199, 86, 72, 1),
              onPressed: () {},
              child: Text(
                'Очистить',
                style: TextStyle(
                    color: Color.fromRGBO(251, 244, 244, 1), fontSize: 24),
              ),
            )),
      ],
    );
  }
}
