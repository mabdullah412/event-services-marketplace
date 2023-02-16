import 'package:dio/dio.dart';

class OrderAPI {
  final baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/orders';

  Future<Response> getOrders({
    required String token,
  }) async {
    return Dio().get(
      baseUrl,
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<Response> placeOrder({
    required String token,
    required String packageId,
  }) async {
    return Dio().post(
      baseUrl,
      data: {'packageId': packageId},
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<Response> cancelOrder({
    required String token,
    required String orderId,
  }) async {
    return Dio().delete(
      baseUrl,
      data: {'orderId': orderId},
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<Response> getSellerOrders({
    required String token,
  }) async {
    return Dio().get(
      '$baseUrl/seller',
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<Response> completeOrder({
    required String token,
    required String orderId,
  }) async {
    return Dio().post(
      '$baseUrl/seller',
      data: {'itemId': orderId},
      options: Options(headers: {'authorization': token}),
    );
  }
}
