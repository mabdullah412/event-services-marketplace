import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../constants/enums.dart';
import 'service.dart';
import 'user.dart';

class Order {
  final String id;
  final User buyer;
  final DateTime createdAt;
  final List<Service> services;
  final int totalPrice;
  final Status status;

  Order({
    required this.id,
    required this.buyer,
    required this.createdAt,
    required this.services,
    required this.totalPrice,
    required this.status,
  });

  Order copyWith({
    String? id,
    User? buyer,
    DateTime? createdAt,
    List<Service>? services,
    int? totalPrice,
    Status? status,
  }) {
    return Order(
      id: id ?? this.id,
      buyer: buyer ?? this.buyer,
      createdAt: createdAt ?? this.createdAt,
      services: services ?? this.services,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buyer': buyer.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'services': services.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      buyer: User.fromMap(map['buyer'] as Map<String, dynamic>),
      createdAt:
          DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['createdAt']).toLocal(),
      services: List<Service>.from(
        (map['items'] as List).map<Service>(
          (item) {
            Map<String, dynamic> service = item['service'];
            service['orderItemId'] = item['_id'];
            service['quantity'] = item['quantity'];
            service['status'] = item['status'];
            return Service.fromMap(service);
          },
        ),
      ),
      totalPrice: map['totalPrice'] as int,
      status: map['status'] == 'pending'
          ? Status.pending
          : map['status'] == 'completed'
              ? Status.completed
              : Status.cancelled,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, buyer: $buyer, createdAt: $createdAt, services: $services, totalPrice: $totalPrice, status: $status)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.buyer == buyer &&
        other.createdAt == createdAt &&
        listEquals(other.services, services) &&
        other.totalPrice == totalPrice &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        buyer.hashCode ^
        createdAt.hashCode ^
        services.hashCode ^
        totalPrice.hashCode ^
        status.hashCode;
  }
}
