part of 'sign_up_bloc.dart';

enum ImagePickState {
  initialy,
  picked,
  failed,
}

class SignUpStates {
  final User? user;

  final String email;
  final String password;
  final String repassword;

  final bool isSignUpLoading;
  final bool signUpSuccess;
  final String? signUpFailure;

  const SignUpStates({
    this.user,
    this.email = "",
    this.password = "",
    this.repassword = "",
    this.isSignUpLoading = false,
    this.signUpSuccess = false,
    this.signUpFailure = "",
  });
  SignUpStates.initial()
      : user = const User(),
        email = "",
        password = "",
        repassword = "",
        signUpSuccess = false,
        signUpFailure = null,
        isSignUpLoading = false;

  SignUpStates copyWith({
    User? user,
    String? firstName,
    String? middleName,
    String? lastName,
    String? fullName,
    String? location,
    String? email,
    String? password,
    String? repassword,
    // PhoneNumber? phoneNumber,
    bool? isValid,
    String? dateOfBirth,
    File? profileImage,
    ImagePickState? imagePickState,
    String? errorImage,
    String? country,
    String? state,
    String? city,
    bool? isSignUpLoading,
    bool? signUpSuccess,
    String? signUpFailure,
    bool? isProfileLoading,
    bool? isProfileSuccess,
    String? profileFailure,
    bool? obscurePassword,
    IconData? iconPassword,
    String? selected,
  }) {
    return SignUpStates(
      user: user ?? user,
      email: email ?? this.email,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
      isSignUpLoading: isSignUpLoading ?? this.isSignUpLoading,
      signUpSuccess: signUpSuccess ?? this.signUpSuccess,
      signUpFailure: signUpFailure ?? this.signUpFailure,
    );
  }
}
