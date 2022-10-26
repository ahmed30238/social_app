class SocialUserModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? uId;
  String? image;
  String? bio;
  String? cover;

  SocialUserModel({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.uId,
    this.cover,
    this.image,
    this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    phone = json['phone'];
    uId = json['uId'];
    email = json['email'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    password = json['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uId': uId,
      'email': email,
      'image': image,
      'cover': cover,
      'password': password,
      'bio': bio,
    };
  }
}
