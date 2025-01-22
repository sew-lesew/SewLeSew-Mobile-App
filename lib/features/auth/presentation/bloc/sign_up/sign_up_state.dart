part of 'sign_up_bloc.dart';

enum ImagePickState {
  initialy,
  picked,
  failed,
}

class SignUpStates {
  final User? user;
  final String? email;
  final String? phoneNumber;
  final String password;
  final String repassword;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final bool isSignUpLoading;
  final bool signUpSuccess;
  final String? signUpFailure;

  const SignUpStates(
      {this.user,
      this.email = "",
      this.password = "",
      this.repassword = "",
      this.firstName = "",
      this.lastName = "",
      this.dateOfBirth = "",
      this.isSignUpLoading = false,
      this.signUpSuccess = false,
      this.signUpFailure = "",
      this.phoneNumber = ""});
  SignUpStates.initial()
      : user = const User(),
        email = null,
        phoneNumber = null,
        password = "",
        repassword = "",
        firstName = "",
        lastName = "",
        dateOfBirth = "",
        signUpSuccess = false,
        signUpFailure = null,
        isSignUpLoading = false;

  SignUpStates copyWith({
    User? user,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? repassword,
    bool? isValid,
    String? dateOfBirth,
    bool? isSignUpLoading,
    bool? signUpSuccess,
    String? signUpFailure,
    bool? isProfileLoading,
    bool? isProfileSuccess,
    bool? obscurePassword,
    IconData? iconPassword,
    String? selected,
  }) {
    return SignUpStates(
      user: user ?? user,
      email: email ?? this.email,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isSignUpLoading: isSignUpLoading ?? this.isSignUpLoading,
      signUpSuccess: signUpSuccess ?? this.signUpSuccess,
      signUpFailure: signUpFailure ?? this.signUpFailure,
    );
  }
}
