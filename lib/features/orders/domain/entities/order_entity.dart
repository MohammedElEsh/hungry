import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String status;
  final double total;
  final String createdAt;
  final String? productImage;

  const OrderEntity({
    required this.id,
    required this.status,
    required this.total,
    required this.createdAt,
    this.productImage,
  });

  @override
  List<Object?> get props => [id, status, total, createdAt, productImage];
}
