import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final String description;

  bool isFavorite;
  int likeCount;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.description,
    this.isFavorite = false,
    this.likeCount = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
