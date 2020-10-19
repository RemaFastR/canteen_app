import 'package:canteen_app/Models/returned_order.dart';
import 'package:canteen_app/functional/api_provider.dart';

class OrderRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<int> createOrder() => apiProvider.createOrder();
  Future<String> getOrderById(int id) => apiProvider.getOrderById(id);
}
