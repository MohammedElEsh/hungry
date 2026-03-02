/// Order from API (GET /orders list response)
class OrderModel {
  final int id;
  final String status;
  final String totalPrice;
  final String createdAt;
  final String? productImage;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    this.productImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: (json['id'] as num).toInt(),
      status: (json['status'] ?? '').toString(),
      totalPrice: (json['total_price'] ?? '0').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
      productImage: json['product_image']?.toString(),
    );
  }
}
