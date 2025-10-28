class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? address;
  final String? visa;
  final String? token;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.address,
    this.visa,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      image: json['image']?.toString(),
      address: json['address']?.toString(),
      visa: json['Visa']?.toString(),
      token: json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'image': image,
    'address': address,
    'Visa': visa,
    'token': token,
  };
}
