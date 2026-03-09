import '../../domain/entities/profile_entity.dart';

class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String? address;
  final String? visa;
  final String? image;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    this.visa,
    this.image,
  });

  static String? _str(dynamic v) {
    if (v == null) return null;
    return v is String ? v : v.toString();
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final id = _str(json['id'] ?? json['user_id']) ?? '';
    final email = _str(json['email'] ?? json['user_email']) ?? '';
    final rawName = _str(json['name'] ?? json['user_name'] ?? json['username']);
    final name = (rawName ?? '').trim().isNotEmpty ? rawName! : email;
    return ProfileModel(
      id: id.isNotEmpty ? id : email,
      name: name,
      email: email,
      address: _str(json['address'] ?? json['user_address']),
      visa: _str(json['Visa'] ?? json['visa'] ?? json['card_number'] ?? json['payment_method']),
      image: _str(json['image'] ?? json['image_url'] ?? json['avatar'] ?? json['photo']),
    );
  }

  ProfileEntity toEntity() => ProfileEntity(
        id: id.isNotEmpty ? id : email,
        name: name,
        email: email,
        address: address?.trim().isEmpty == true ? null : address,
        visa: visa?.trim().isEmpty == true ? null : visa,
        image: image?.trim().isEmpty == true ? null : image,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'address': address,
        'visa': visa,
        'image': image,
      };
}
