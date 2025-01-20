// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
