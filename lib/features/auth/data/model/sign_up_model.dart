import 'dart:convert';

class SignUpModel {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;

  SignUpModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
