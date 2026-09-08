import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: json['created_at'],
    );
  }
}

extension UserModelMapper on UserModel {
  UserEntity toEntity() =>
      UserEntity(
        id: id,
        name: name, 
        email: email, 
        createdAt: createdAt
      );
}
