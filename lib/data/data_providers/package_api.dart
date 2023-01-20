import 'package:dio/dio.dart';

class PackageAPI {
  final baseUrl =
      'https://event-services-marketplace-api.vercel.app/api/v1/packages';

  Future<Response> getPackages({
    required String token,
  }) async {
    return await Dio().get(
      baseUrl,
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<dynamic> createPackage({
    required String token,
    required String name,
  }) async {
    return await Dio().post(
      baseUrl,
      data: {'name': name},
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<dynamic> deletePackage({
    required String token,
    required String packageId,
  }) async {
    return await Dio().delete(
      baseUrl,
      data: {'packageId': packageId},
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<dynamic> addToPackage({
    required String token,
    required String packageId,
    required String serviceId,
  }) async {
    return Dio().post(
      '$baseUrl/service',
      data: {
        'packageId': packageId,
        'serviceId': serviceId,
      },
      options: Options(headers: {'authorization': token}),
    );
  }

  Future<dynamic> removeFromPackage({
    required String token,
    required String packageId,
    required String serviceId,
  }) async {
    return Dio().delete(
      '$baseUrl/service',
      data: {
        'packageId': packageId,
        'serviceId': serviceId,
      },
      options: Options(headers: {'authorization': token}),
    );
  }
}
