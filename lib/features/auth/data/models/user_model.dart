class UserModel {
  String name;
  String email;
  String? image;
  String? address;
  String? visa;
  String token;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.address,
    this.visa,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'] as String,
    email: json['email'] as String,
    image: json['image'] as String?,
    address: json['address'] as String?,
    visa: json['Visa'] as String?,
    token: json['token'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'image': image,
    'address': address,
    'Visa': visa,
    'token': token,
  };
}
