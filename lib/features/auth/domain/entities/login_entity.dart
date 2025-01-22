class LoginEntity {
  final String? email;
  final String? phoneNumber;
  final String password;

  LoginEntity({
    this.phoneNumber,
    this.email,
    required this.password,
  });
}
