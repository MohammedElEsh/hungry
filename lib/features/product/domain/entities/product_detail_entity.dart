import 'package:equatable/equatable.dart';

import 'side_option_entity.dart';
import 'topping_entity.dart';

class ProductDetailEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String? description;
  final String? image;
  final List<ToppingEntity> toppings;
  final List<SideOptionEntity> sideOptions;

  const ProductDetailEntity({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.image,
    this.toppings = const [],
    this.sideOptions = const [],
  });

  @override
  List<Object?> get props => [id, name, price, description, image, toppings, sideOptions];
}
