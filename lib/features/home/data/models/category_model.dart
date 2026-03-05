import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.id, required super.name});

  static String? _str(dynamic v) {
    if (v == null) return null;
    return v is String ? v : v.toString();
  }

  factory CategoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return const CategoryModel(id: '', name: '');
    }
    final name = _str(json['name']) ??
        _str(json['title']) ??
        _str(json['category_name']) ??
        _str(json['categoryName']) ??
        '';
    return CategoryModel(
      id: _str(json['id']) ?? _str(json['category_id']) ?? '',
      name: name,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
