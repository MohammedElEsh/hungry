import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? address;
  final String? visa;
  final String? image;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    this.visa,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, email, address, visa, image];
}
