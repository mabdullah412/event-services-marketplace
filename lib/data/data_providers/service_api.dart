import 'package:dio/dio.dart';

class ServiceAPI {
  final String baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/services';

  Future<Response> getServices({required String category}) async {
    return await Dio().get(
      baseUrl,
      queryParameters: {'category': category},
    );
  }

  Future<Response> getUserServices({required String token}) async {
    return await Dio().get(
      '$baseUrl/user',
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<Response> createService({
    required String token,
    required Map<dynamic, dynamic> serviceData,
  }) async {
    return await Dio().post(
      baseUrl,
      data: serviceData,
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<Response> deleteService({
    required String token,
    required String serviceId,
  }) async {
    return await Dio().delete(
      '$baseUrl/$serviceId',
      options: Options(headers: {'authorization': token}),
    );
  }
}
