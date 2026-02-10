import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final int id;
  final String name;
  final String email;
  final String token;
  final String? mobile;
  final String? photoId;
  final String? photo;
  String? password;


  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.mobile,
    this.photoId,
    this.photo,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, token, mobile, photoId, photo];

}