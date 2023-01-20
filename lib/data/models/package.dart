// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'service.dart';
import 'user.dart';

class Package {
  final String id;
  final String name;
  final User buyer;
  final DateTime createdAt;
  final List<Service> services;
  Package({
    required this.id,
    required this.name,
    required this.buyer,
    required this.createdAt,
    required this.services,
  });

  Package copyWith({
    String? id,
    String? name,
    User? buyer,
    DateTime? createdAt,
    List<Service>? services,
  }) {
    return Package(
      id: id ?? this.id,
      name: name ?? this.name,
      buyer: buyer ?? this.buyer,
      createdAt: createdAt ?? this.createdAt,
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'buyer': buyer.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'services': services.map((x) => x.toMap()).toList(),
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      id: map['_id'] as String,
      name: map['name'] as String,
      buyer: User.fromMap(map['buyer'] as Map<String, dynamic>),
      createdAt:
          DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['createdAt']).toLocal(),
      services: List<Service>.from(
        (map['services'] as List).map<Service>(
          (service) => Service.fromMap(service as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Package(id: $id, name: $name, buyer: $buyer, createdAt: $createdAt, services: $services)';
  }

  @override
  bool operator ==(covariant Package other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.buyer == buyer &&
        other.createdAt == createdAt &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        buyer.hashCode ^
        createdAt.hashCode ^
        services.hashCode;
  }
}
