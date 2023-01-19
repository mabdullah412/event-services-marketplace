import 'package:dio/dio.dart';

class ReviewAPI {
  final String baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/services';

  Future<dynamic> getReviews({required String serviceId}) async {
    return await Dio().get('$baseUrl/$serviceId/reviews');
  }

  Future<dynamic> createReview({
    required String token,
    required String serviceId,
    required Map<dynamic, dynamic> reviewData,
  }) async {
    return await Dio().post(
      '$baseUrl/$serviceId/reviews',
      data: reviewData,
      options: Options(headers: {'authorization': token}),
    );
  }
}
