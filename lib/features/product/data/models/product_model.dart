class ProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  String? rating;
  String? price;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.rating,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final idRaw = json['id'] ?? json['product_id'];
    final id = idRaw is int
        ? idRaw
        : idRaw is num
            ? idRaw.toInt()
            : idRaw != null
                ? int.tryParse(idRaw.toString())
                : null;
    final priceRaw = json['price'] ?? json['amount'];
    final price = priceRaw is num
        ? priceRaw.toString()
        : priceRaw?.toString();
    final image = json['image']?.toString() ??
        json['image_url']?.toString() ??
        json['imageUrl']?.toString() ??
        json['photo']?.toString();
    final name = json['name']?.toString() ??
        json['title']?.toString() ??
        json['product_name']?.toString();
    return ProductModel(
      id: id,
      name: name,
      description: json['description']?.toString(),
      image: image,
      rating: json['rating']?.toString(),
      price: price,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'rating': rating,
    'price': price,
  };
}
