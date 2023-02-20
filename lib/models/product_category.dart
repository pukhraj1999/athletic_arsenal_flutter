import 'dart:convert';

class ProductCategory {
  String? id;
  final String category;

  ProductCategory({
    required this.category,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'id': id,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      category: map['category'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source));
}
