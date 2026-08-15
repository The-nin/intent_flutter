import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String? title;
  final String? thumbnail;
  final double? price;
  final String? description;

  ProductModel({
    this.id,
    this.title,
    this.thumbnail,
    this.price,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product toEntity() {
    return Product(
      id: id ?? 0,
      title: title ?? '',
      thumbnail: thumbnail ?? '',
      price: price ?? 0.0,
      description: description ?? '',
    );
  }
}
