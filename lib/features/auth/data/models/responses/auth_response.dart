import 'package:pharmacy_management/features/auth/data/models/responses/auth_me_response.dart';
import 'package:pharmacy_management/features/auth/domain/entity/auth_entity.dart';

class AuthResponse {
  final String token;
  final String tokenType;
  final UserModel user;

  AuthResponse({
    required this.token,
    required this.tokenType,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      tokenType: json['token_type'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}


extension AuthResponseMapper on AuthResponse {
  AuthEntity toEntity() => AuthEntity(
    token: token,
    tokenType: tokenType,
    user: UserEntity(
      id: user.id,
      name: user.name,
      email: user.email,
      createdAt: user.createdAt,
    ),
  );
}
