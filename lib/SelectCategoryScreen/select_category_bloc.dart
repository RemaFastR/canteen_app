import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/SelectCategoryScreen/select_category_repos.dart';
import 'package:canteen_app/functional/main_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SelectCategoryBloc implements Bloc {
  SelectCategoryRepository _categoryRepository = SelectCategoryRepository();

  final _categoryFetcher = PublishSubject<List<Product>>();

  Observable<List<Product>> get categoryStream => _categoryFetcher.stream;

  getSelectCategory(int id) async {
    List<Product> categories = await _categoryRepository.getCategories(id);
    _categoryFetcher.sink.add(categories);
  }

  @override
  void dispose() {
    _categoryFetcher.close();
  }
}

final categoryBloc = SelectCategoryBloc();
