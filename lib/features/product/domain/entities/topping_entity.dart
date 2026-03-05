import 'package:equatable/equatable.dart';

class ToppingEntity extends Equatable {
  final int id;
  final String name;
  final String image;

  const ToppingEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
