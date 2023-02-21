import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data_providers/order_api.dart';
import '../models/order.dart';
import '../models/service.dart';

class OrderRepository {
  final OrderAPI _orderAPI = OrderAPI();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<List<Order>> getOrders() async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';

    final Response rawData = await _orderAPI.getOrders(token: token);
    final List<dynamic> rawOrders = rawData.data['data']['orders'] as List;

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

  Future<List<Service>> getSellerOrders() async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';

    final Response rawData = await _orderAPI.getSellerOrders(token: token);
    final List<dynamic> rawOrders = rawData.data['data']['items'] as List;

    final List<Service> items = rawOrders
        .map(
          (item) => Service.fromMapItem(item),
        )
        .toList();

    return items;
  }

  Future<dynamic> completeOrder({
    required String orderId,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _orderAPI.completeOrder(token: token, orderId: orderId);
  }
}
