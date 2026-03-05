import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String? rating;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.rating,
  });

  @override
  List<Object?> get props => [id, name, price, imageUrl, rating];
}
