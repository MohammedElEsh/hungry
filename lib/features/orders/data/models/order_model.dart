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
    final idRaw = json['id'];
    final id = idRaw is int
        ? idRaw
        : idRaw is num
            ? idRaw.toInt()
            : int.tryParse(idRaw?.toString() ?? '') ?? 0;
    return OrderModel(
      id: id,
      status: json['status']?.toString() ?? '',
      totalPrice: json['total_price']?.toString() ?? '0',
      createdAt: json['created_at']?.toString() ?? '',
      productImage: json['product_image']?.toString(),
    );
  }
}
