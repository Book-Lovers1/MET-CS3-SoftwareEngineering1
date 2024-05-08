class UserEntity {
  final String userId;
  final String? email;
  final String password;
  final String? name;
  final num? age;

  UserEntity({
    required this.userId,
    required this.email,
    required this.password,
    required this.name,
    required this.age,
  });
}
