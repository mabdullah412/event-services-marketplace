import 'dart:convert';

class User {
  final String id;
  final String name;
  final String photo;
  User({
    required this.id,
    required this.name,
    required this.photo,
  });

  User copyWith({
    String? id,
    String? name,
    String? photo,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'photo': photo,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Seller(id: $id, name: $name, photo: $photo)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.photo == photo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ photo.hashCode;
}
