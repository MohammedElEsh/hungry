import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    super.token,
    super.address,
    super.visa,
    super.image,
  });

  static String? _str(dynamic v) {
    if (v == null) return null;
    return v is String ? v : v.toString();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = _str(json['id'] ?? json['user_id']) ?? '';
    final email = _str(json['email'] ?? json['user_email']) ?? '';
    return UserModel(
      id: id,
      email: email,
      name: _str(json['name'] ?? json['user_name'] ?? json['username']),
      token: _str(json['token'] ?? json['access_token'] ?? json['auth_token']),
      address: _str(json['address'] ?? json['user_address']),
      visa: _str(json['Visa'] ?? json['visa'] ?? json['card_number'] ?? json['payment_method']),
      image: _str(json['image'] ?? json['image_url'] ?? json['avatar'] ?? json['photo']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'token': token,
        'address': address,
        'visa': visa,
        'image': image,
      };
}
