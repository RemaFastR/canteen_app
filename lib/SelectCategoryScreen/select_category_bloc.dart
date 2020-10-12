import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_repos.dart';
import 'package:canteen_app/functional/attributes.dart';
import 'package:canteen_app/functional/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';

class SelectCategoryBloc implements Bloc {
  SelectCategoryRepository _categoryRepository = SelectCategoryRepository();

  final _categoryFetcher = PublishSubject<List<Product>>();

  Observable<List<Product>> get categoryStream => _categoryFetcher.stream;

  getSelectCategory(int id) async {
    List<Product> categories = await _categoryRepository.getCategories(id);
    _categoryFetcher.sink.add(categories);
  }

  addInOrder(int id, String title, String image, double cost,
      BuildContext scaffoldContext) async {
    bool checker = false;
    ProductForOrder productForOrder = new ProductForOrder(
        id: id, quantity: 1, title: title, image: image, cost: cost);
    for (var i = 0; i < orderProductsList.length; i++) {
      if (orderProductsList[i].id == productForOrder.id) {
        checker = true;
      }
    }
    print('------------ Order ------------');
    if (checker) {
      // showToast(scaffoldContext, 'Блюдо блюдо уже добавлено в корзину',
      //     cleanOrderButtonColor);
    } else {
      print("product with id ${id} added in order");
      showToast(scaffoldContext, 'Блюдо добавлено в корзину', productInfoColor);
      orderProductsList.add(productForOrder);
      print("order list count is ${orderProductsList.length}");
    }
    print('------------  ------------');
  }

  void showToast(BuildContext context, String message, Color textColor) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: titlesColor,
        content: Text(message,
            style: TextStyle(
              color: textColor,
            )),
        action: SnackBarAction(
            label: 'Хорошо', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void dispose() {
    _categoryFetcher.close();
  }
}

final categoryBloc = SelectCategoryBloc();
