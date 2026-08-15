class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.description,
  });

  double getDiscountedPrice(double discount) {
    return price * (1 - discount / 100);
  }
}
