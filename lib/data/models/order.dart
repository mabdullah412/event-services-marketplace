import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'service.dart';
import 'user.dart';

class Order {
  final String id;
  final User buyer;
  final DateTime createdAt;
  final List<Service> services;

  Order({
    required this.id,
    required this.buyer,
    required this.createdAt,
    required this.services,
  });

  Order copyWith({
    String? id,
    User? buyer,
    DateTime? createdAt,
    List<Service>? services,
  }) {
    return Order(
      id: id ?? this.id,
      buyer: buyer ?? this.buyer,
      createdAt: createdAt ?? this.createdAt,
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buyer': buyer.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'services': services.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      buyer: User.fromMap(map['buyer'] as Map<String, dynamic>),
      createdAt:
          DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['createdAt']).toLocal(),
      services: List<Service>.from(
        (map['services'] as List).map<Service>(
          (x) => Service.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, buyer: $buyer, createdAt: $createdAt, services: $services)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.buyer == buyer &&
        other.createdAt == createdAt &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        buyer.hashCode ^
        createdAt.hashCode ^
        services.hashCode;
  }
}
