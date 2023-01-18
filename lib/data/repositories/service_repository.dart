import '../data_providers/service_api.dart';
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
}
