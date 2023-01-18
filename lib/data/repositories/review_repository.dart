import '../data_providers/review_api.dart';
import '../models/review.dart';

class ReviewRepository {
  final ReviewAPI _reviewAPI = ReviewAPI();

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
}
