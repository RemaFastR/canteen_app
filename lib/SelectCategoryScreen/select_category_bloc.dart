import 'package:canteen_app/Models/order.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_repos.dart';
import 'package:canteen_app/functional/main_bloc.dart';
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

  addInOrder(int id, String title, String image, int cost) async {
    print('------------ Order ------------');
    print("product with id ${id} added in order");
    orderProductsList.add(new ProductForOrder(
        id: id, quantity: 1, title: title, image: image, cost: cost));
    print("order list count is ${orderProductsList.length}");
    print('------------  ------------');
  }

  @override
  void dispose() {
    _categoryFetcher.close();
  }
}

final categoryBloc = SelectCategoryBloc();
