import 'dart:convert';

import 'package:intl/intl.dart';

import 'user.dart';

class Review {
  final String id;
  final String review;
  final User author;
  final String service;
  final int rating;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.review,
    required this.author,
    required this.service,
    required this.rating,
    required this.createdAt,
  });

  Review copyWith({
    String? id,
    String? review,
    User? author,
    String? service,
    int? rating,
    DateTime? createdAt,
  }) {
    return Review(
      id: id ?? this.id,
      review: review ?? this.review,
      author: author ?? this.author,
      service: service ?? this.service,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'review': review,
      'author': author.toMap(),
      'service': service,
      'rating': rating,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      review: map['review'] as String,
      author: User.fromMap(map['author'] as Map<String, dynamic>),
      service: map['service'] as String,
      rating: map['rating'] as int,
      createdAt:
          DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, review: $review, author: $author, service: $service, rating: $rating, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.review == review &&
        other.author == author &&
        other.service == service &&
        other.rating == rating &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        review.hashCode ^
        author.hashCode ^
        service.hashCode ^
        rating.hashCode ^
        createdAt.hashCode;
  }
}
