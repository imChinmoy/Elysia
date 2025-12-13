class UserEntity {
  final String email;
  final String password;
  final String username;
  final String profilePictureUrl;
  final int phoneNumber;

  UserEntity({
    required this.email,
    required this.password,
    required this.username,
    required this.profilePictureUrl,
    required this.phoneNumber,
  });
}