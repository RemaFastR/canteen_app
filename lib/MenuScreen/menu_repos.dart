import 'package:canteen_app/functional/api_provider.dart';

class CategoryRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<List> getCategories() => apiProvider.getCategories();
}
