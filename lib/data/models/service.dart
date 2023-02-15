// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../constants/enums.dart';
import 'user.dart';

class Service {
  final String id;
  final User seller;
  final String title;
  final String description;
  final String location;
  final String category;
  final String coverImage;
  final int price;
  final int ratingsQuantity;
  final int ratingsAverage;

  final int? quantity;
  final Status? status;
  final String? orderItemId;
  final User? buyer;

  Service({
    required this.id,
    required this.seller,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.coverImage,
    required this.price,
    required this.ratingsQuantity,
    required this.ratingsAverage,
    this.quantity,
    this.status,
    this.orderItemId,
    this.buyer,
  });

  Service copyWith({
    String? id,
    User? seller,
    String? title,
    String? description,
    String? location,
    String? category,
    String? coverImage,
    int? price,
    int? ratingsQuantity,
    int? ratingsAverage,
    int? quantity,
    Status? status,
    String? orderItemId,
    User? buyer,
  }) {
    return Service(
      id: id ?? this.id,
      seller: seller ?? this.seller,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      coverImage: coverImage ?? this.coverImage,
      price: price ?? this.price,
      ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity,
      ratingsAverage: ratingsAverage ?? this.ratingsAverage,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      orderItemId: orderItemId ?? this.orderItemId,
      buyer: buyer ?? this.buyer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'seller': seller.toMap(),
      'title': title,
      'description': description,
      'location': location,
      'category': category,
      'coverImage': coverImage,
      'price': price,
      'ratingsQuantity': ratingsQuantity,
      'ratingsAverage': ratingsAverage,
      'quantity': quantity,
      'status': status,
      'orderItemId': orderItemId,
      'buyer': buyer?.toMap(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['_id'] as String,
      seller: User.fromMap(map['seller'] as Map<String, dynamic>),
      title: map['title'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      category: map['category'] as String,
      coverImage: map['coverImage'] as String,
      price: map['price'] as int,
      ratingsQuantity: map['ratingsQuantity'] as int,
      ratingsAverage: map['ratingsAverage'] as int,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null
          ? map['status'] == 'pending'
              ? Status.pending
              : Status.completed
          : null,
      orderItemId:
          map['orderItemId'] != null ? map['orderItemId'] as String : null,
      buyer: map['buyer'] != null
          ? User.fromMap(map['buyer'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Service(id: $id, seller: $seller, title: $title, description: $description, location: $location, category: $category, coverImage: $coverImage, price: $price, ratingsQuantity: $ratingsQuantity, ratingsAverage: $ratingsAverage, quantity: $quantity, status: $status, orderItemId: $orderItemId, buyer: $buyer)';
  }

  @override
  bool operator ==(covariant Service other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.seller == seller &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.category == category &&
        other.coverImage == coverImage &&
        other.price == price &&
        other.ratingsQuantity == ratingsQuantity &&
        other.ratingsAverage == ratingsAverage &&
        other.quantity == quantity &&
        other.status == status &&
        other.orderItemId == orderItemId &&
        other.buyer == buyer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        seller.hashCode ^
        title.hashCode ^
        description.hashCode ^
        location.hashCode ^
        category.hashCode ^
        coverImage.hashCode ^
        price.hashCode ^
        ratingsQuantity.hashCode ^
        ratingsAverage.hashCode ^
        quantity.hashCode ^
        status.hashCode ^
        orderItemId.hashCode ^
        buyer.hashCode;
  }
}
