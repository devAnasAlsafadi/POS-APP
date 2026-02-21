import 'package:pos_wiz_tech/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.token,
    super.mobile,
    super.photoId,
    super.photo,

});


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

    final userData = data['user'] as Map<String, dynamic>? ?? data;

    return UserModel(
      id: userData['id'] ?? 0,
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      token: data['token'] ?? '',
      mobile: userData['mobile']?.toString(),
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