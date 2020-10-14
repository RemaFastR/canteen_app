import 'package:canteen_app/Models/product.dart';
import 'package:canteen_app/functional/api_provider.dart';

class SelectCategoryRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<List<Product>> getProductsFromCategory(int id) =>
      apiProvider.getProductsFromCategory(id);
}
