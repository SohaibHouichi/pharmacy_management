class AuthEntity {
  final String token;
  final String tokenType;
  final UserEntity user;

  const AuthEntity({
    required this.token,
    required this.tokenType,
    required this.user,
  });
}

class UserEntity {
  final int id;
  final String name;
  final String email;
  final String createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });
}
