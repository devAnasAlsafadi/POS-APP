import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  final int id;
  final String name;
  final String email;
  final String token;
  final String? mobile;
  final String? photoId;
  final String? photo;
   String?  password;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.mobile,
    this.photoId,
    this.photo,
  }) : super(id: id, name: name, email: email, token: token, mobile: mobile, photoId: photoId, photo: photo);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      token: token,
      mobile: mobile,
      photoId: photoId,
      photo: photo,
    );
  }



  factory UserModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>? ?? json;
    final userData = data['user'] as Map<String, dynamic>? ?? {};

    return UserModel(
      id: userData['id'] ?? 0,
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      token: data['token'] ?? '',
      mobile: userData['mobile']?.toString(), // Safely convert to string if not null
      photoId: userData['photo_id']?.toString(),
      photo: userData['photo']?.toString(),
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }







}