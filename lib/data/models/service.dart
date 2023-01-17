import 'dart:convert';

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
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Service(id: $id, seller: $seller, title: $title, description: $description, location: $location, category: $category, coverImage: $coverImage, price: $price, ratingsQuantity: $ratingsQuantity, ratingsAverage: $ratingsAverage)';
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
        other.ratingsAverage == ratingsAverage;
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
        ratingsAverage.hashCode;
  }
}
