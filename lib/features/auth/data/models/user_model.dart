class UserModel {
  final int id;
  final String name;
  final String email;
  final String token;
  final String? mobile;
  final String? photoId;
  final String? photo;
   String? password;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.mobile,
    this.photoId,
    this.photo,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      mobile: json['mobile'] as String?,
      photoId: json['photo_id'] as String?,
      photo: json['photo'] as String?,
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }







}