import '../models/product.dart';

final List<String> bannerImages = [
  'https://picsum.photos/id/1011/800/400',
  'https://picsum.photos/id/1015/800/400',
  'https://picsum.photos/id/1025/800/400',
];

final List<Product> fakeProducts = [
  Product(
    id: 'p1',
    name: 'Áo thun basic',
    image: 'https://picsum.photos/id/21/400/400',
    price: 150000,
    description:'Áo thun cotton 100%, form rộng thoải mái, phù hợp mặc hằng ngày.',
  ),
  Product(
    id: 'p2',
    name: 'Quần jean slimfit',
    image: 'https://picsum.photos/id/26/400/400',
    price: 350000,
    description: 'Quần jean co giãn nhẹ, dáng slimfit trẻ trung, năng động.',
  ),
  Product(
    id: 'p3',
    name: 'Giày sneaker trắng',
    image: 'https://picsum.photos/id/103/400/400',
    price: 500000,
    description: 'Giày sneaker màu trắng basic, dễ phối đồ, đế êm chân.',
  ),
  Product(
    id: 'p4',
    name: 'Balo laptop',
    image: 'https://picsum.photos/id/119/400/400',
    price: 280000,
    description: 'Balo chống nước, ngăn đựng laptop 15.6 inch tiện lợi.',
  ),
  Product(
    id: 'p5',
    name: 'Mũ lưỡi trai',
    image: 'https://picsum.photos/id/145/400/400',
    price: 90000,
    description: 'Mũ lưỡi trai chất liệu kaki, chống nắng tốt.',
  ),
  Product(
    id: 'p6',
    name: 'Đồng hồ thể thao',
    image: 'https://picsum.photos/id/175/400/400',
    price: 620000,
    description: 'Đồng hồ thể thao chống nước, đo nhịp tim cơ bản.',
  ),
];