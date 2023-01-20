import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data_providers/package_api.dart';
import '../models/package.dart';

class PackageRepository {
  final PackageAPI _packageAPI = PackageAPI();
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<List<Package>> getPackages() async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';

    final Response rawData = await _packageAPI.getPackages(token: token);
    final List<dynamic> rawPackages = rawData.data['data']['packages'] as List;

    final List<Package> packages = rawPackages
        .map(
          (package) => Package.fromMap(package),
        )
        .toList();

    return packages;
  }

  Future<dynamic> createPackage({
    required String name,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _packageAPI.createPackage(token: token, name: name);
  }

  Future<dynamic> deletePackage({
    required String packageId,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _packageAPI.deletePackage(token: token, packageId: packageId);
  }

  Future<dynamic> addToPackage({
    required String packageId,
    required String serviceId,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _packageAPI.addToPackage(
      token: token,
      packageId: packageId,
      serviceId: serviceId,
    );
  }

  Future<dynamic> removeFromPackage({
    required String packageId,
    required String serviceId,
  }) async {
    final String token =
        await _flutterSecureStorage.read(key: 'JWT_TOKEN') ?? '';
    if (token == '') return false;

    return await _packageAPI.removeFromPackage(
      token: token,
      packageId: packageId,
      serviceId: serviceId,
    );
  }
}
