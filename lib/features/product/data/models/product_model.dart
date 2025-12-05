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

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    rating: json['rating'] as String?,
    price: json['price'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'rating': rating,
    'price': price,
  };
}
