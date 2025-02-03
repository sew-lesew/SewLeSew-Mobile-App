class SignUpEntity {
  final String? email;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;
  final String dateOfBirth;
  final String? phoneNumber;

  SignUpEntity({
    this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.dateOfBirth,
  });
}
