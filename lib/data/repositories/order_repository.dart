import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data_providers/order_api.dart';
import '../models/order.dart';

class OrderRepository {
  final OrderAPI _orderAPI = OrderAPI();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<List<Order>> getOrders() async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';

    final Response rawData = await _orderAPI.getOrders(token: token);
    final List<dynamic> rawOrders = rawData.data['data']['packages'] as List;

    final List<Order> orders = rawOrders
        .map(
          (order) => Order.fromMap(order),
        )
        .toList();

    return orders;
  }

  Future<dynamic> placeOrder({
    required String packageId,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _orderAPI.placeOrder(token: token, packageId: packageId);
  }

  Future<dynamic> cancelOrder({
    required String orderId,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _orderAPI.cancelOrder(token: token, orderId: orderId);
  }
}
