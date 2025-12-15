class UserEntity {
  final String id;
  final String email;
  final String username;
  final String? phoneNumber;
  final String? role;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    this.phoneNumber,
    this.role,
  });
}
