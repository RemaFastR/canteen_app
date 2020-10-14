import 'package:canteen_app/functional/api_provider.dart';

class OrderRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<int> createOrder() => apiProvider.createOrder();
}
