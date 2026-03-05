class ToppingModel {
  final int id;
  final String name;
  final String image;

  ToppingModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    final idRaw = json['id'];
    final id = idRaw is int
        ? idRaw
        : idRaw is num
            ? idRaw.toInt()
            : int.tryParse(idRaw?.toString() ?? '') ?? 0;
    return ToppingModel(
      id: id,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
