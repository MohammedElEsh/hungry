import 'package:equatable/equatable.dart';

/// User entity.
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? token;
  final String? address;
  final String? visa;
  final String? image;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.token,
    this.address,
    this.visa,
    this.image,
  });

  @override
  List<Object?> get props => [id, email, name, token, address, visa, image];
}
