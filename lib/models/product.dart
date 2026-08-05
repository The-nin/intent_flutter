class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;

  bool isFavorite;
  int likeCount;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.isFavorite = false,
    this.likeCount = 0,
  });
}