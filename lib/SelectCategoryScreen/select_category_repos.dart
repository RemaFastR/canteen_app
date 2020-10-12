import 'package:canteen_app/Models/category.dart';
import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/functional/api_provider.dart';
import 'package:canteen_app/functional/attributes.dart';

class SelectCategoryRepository {
  ApiProvider apiProvider = ApiProvider();

  //Future<List> getCategories() => apiProvider.getCategories();

  Future<List<Product>> getCategories(int id) async {
    Category category;
    for (var cat in StaticVariables.staticCategories) {
      if (cat.id == id) category = cat;
    }
    List<Product> products = category.products;
    return products;
  }
}
