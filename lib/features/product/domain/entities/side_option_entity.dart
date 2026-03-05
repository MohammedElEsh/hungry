import 'package:equatable/equatable.dart';

class SideOptionEntity extends Equatable {
  final int id;
  final String name;
  final String image;

  const SideOptionEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}
