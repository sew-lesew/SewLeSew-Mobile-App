import 'dart:convert';

class SignUpModel {
  final String? email;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;
  final String dateOfBirth;
  final String? phoneNumber;

  SignUpModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.dateOfBirth,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'passwordConfirm': confirmPassword,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
    };
  }

  String toJson() => json.encode(toMap());
}
