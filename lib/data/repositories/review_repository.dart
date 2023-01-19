import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data_providers/review_api.dart';
import '../models/review.dart';

class ReviewRepository {
  final ReviewAPI _reviewAPI = ReviewAPI();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<List<Review>> getReviews({required String serviceId}) async {
    final rawData = await _reviewAPI.getReviews(serviceId: serviceId);
    final List<dynamic> rawReviews = rawData.data['data']['reviews'] as List;

    final List<Review> reviews = rawReviews
        .map(
          (review) => Review.fromMap(review),
        )
        .toList();

    return reviews;
  }

  Future<dynamic> createReview({
    required String serviceId,
    required Map<dynamic, dynamic> reviewData,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _reviewAPI.createReview(
      token: token,
      serviceId: serviceId,
      reviewData: reviewData,
    );
  }
}
