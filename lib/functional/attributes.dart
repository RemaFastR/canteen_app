import 'package:canteen_app/Models/category.dart';
import 'package:canteen_app/Models/order.dart';
import 'package:flutter/material.dart';

const barsColor = Color.fromRGBO(231, 181, 127, 1);
const titlesColor = Color.fromRGBO(251, 244, 244, 1);
const cardsColor = Color.fromRGBO(166, 192, 133, 1);
const productInfoColor = Color.fromRGBO(64, 55, 55, 1);
const orderProductCostColor = Color.fromRGBO(164, 74, 63, 1);
const createOrderButtonColor = Color.fromRGBO(248, 144, 144, 1);
const cleanOrderButtonColor = Color.fromRGBO(199, 86, 72, 1);
const orderDetailTitleColor = Color.fromRGBO(156, 137, 126, 1);
const orderDetailBackgroundColor = Color.fromRGBO(228, 230, 195, 1);

class ScreenSize {
  static var size;
  static double itemHeight;
  static double itemWidth;
}

class CustomAlertDialog extends StatelessWidget {
  final alertTitle;
  final alertText;
  final List<Widget> buttons;

  CustomAlertDialog(
      {@required this.alertTitle,
      @required this.alertText,
      @required this.buttons});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: titlesColor,
        title: Text(
          alertTitle,
          style: TextStyle(color: productInfoColor),
        ),
        content: Text(
          alertText,
          style: TextStyle(color: productInfoColor),
        ),
        actions: buttons);
  }
}

class StaticVariables {
  static List<Category> staticCategories;
  static List<ProductForOrder> orderProductsList;
}
