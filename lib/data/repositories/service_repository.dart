import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data_providers/service_api.dart';
import '../models/service.dart';

class ServiceRepository {
  final ServiceAPI _serviceAPI = ServiceAPI();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

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

  Future<dynamic> createService({
    required Map<dynamic, dynamic> serviceData,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _serviceAPI.createService(
      token: token,
      serviceData: serviceData,
    );
  }
}
