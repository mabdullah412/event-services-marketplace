import '../data_providers/service_api.dart';
import '../models/review.dart';
import '../models/service.dart';

class ServiceRepository {
  final ServiceAPI _serviceAPI = ServiceAPI();

  Future<List<Service>> getServices({required String category}) async {
    final rawData = await _serviceAPI.getServices(category: category);
    final List<dynamic> rawServices = rawData.data['data']['services'] as List;

    final List<Service> services = rawServices
        .map(
          (service) => Service.fromMap(service),
        )
        .toList();

    return services;
  }

  Future<List<Review>> getReviews({required String serviceId}) async {
    final rawData = await _serviceAPI.getReviews(serviceId: serviceId);
    final List<dynamic> rawReviews = rawData.data['data']['reviews'] as List;

    final List<Review> reviews = rawReviews
        .map(
          (review) => Review.fromMap(review),
        )
        .toList();

    return reviews;
  }
}
