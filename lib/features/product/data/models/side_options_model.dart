class SideOptionsModel {
  final int id;
  final String name;
  final String image;

  SideOptionsModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SideOptionsModel.fromJson(Map<String, dynamic> json) {
    final idRaw = json['id'];
    final id = idRaw is int
        ? idRaw
        : idRaw is num
            ? idRaw.toInt()
            : int.tryParse(idRaw?.toString() ?? '') ?? 0;
    return SideOptionsModel(
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
