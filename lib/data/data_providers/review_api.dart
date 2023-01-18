import 'package:dio/dio.dart';

class ReviewAPI {
  final String baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/services';

  Future<dynamic> getReviews({required String serviceId}) async {
    return await Dio().get('$baseUrl/$serviceId/reviews');
  }
}
