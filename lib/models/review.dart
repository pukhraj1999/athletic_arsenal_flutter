import 'dart:convert';

class Review {
  final String userId;
  final String userName;
  final double rating;
  final String review;

  Review({
    required this.userId,
    required this.userName,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'review': review,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      userId: map['userId'],
      userName: map['userName'],
      rating: map['rating']?.toDouble() ?? 0.0,
      review: map['review'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
