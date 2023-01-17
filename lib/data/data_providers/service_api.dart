import 'package:dio/dio.dart';

class ServiceAPI {
  final String baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/services';

  Future<dynamic> getServices({required String category}) async {
    return await Dio().get(
      baseUrl,
      queryParameters: {'category': category},
    );
  }

  Future<dynamic> getReviews({required String serviceId}) async {
    return await Dio().get('$baseUrl/$serviceId/reviews');
  }
}
