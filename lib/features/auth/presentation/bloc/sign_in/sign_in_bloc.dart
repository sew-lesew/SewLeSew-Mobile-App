import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/login.dart';
import 'package:sewlesew_fund/injection_container.dart';
import '../../../../../core/resources/shared_event.dart';
import '../../../../../core/util/ethiopian_phone_validator.dart';
import '../../../domain/entities/login_entity.dart';
import '../../../domain/usecases/google_signin.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SharedEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<ContactEvent>(_contactEvent);
    on<PasswordEvent>(_passwordEvent);
    on<SignInReset>(_resetToInitial);
    on<SignInSubmitEvent>(_signInSubmitEvent);
    on<GoogleSignInEvent>(_googleSignInEvent);
    // on<TogglePasswordVisibility>(togglePasswordVisibility);
  }
  Future<void> _signInSubmitEvent(
      SignInSubmitEvent event, Emitter<SignInState> emit) async {
    print("Received SignInSubmitEvent with:");
    print(" - Email: ${event.email}");
    print(" - Phone: ${event.phoneNumber}");
    print(" - Password: ${event.password != null ? '******' : 'EMPTY'}");

    emit(state.copyWith(isSignInLoading: true));
    try {
      final loginInfo = LoginEntity(
          phoneNumber: event.phoneNumber != null
              ? EthiopianPhoneValidator.normalize(event.phoneNumber!)
              : null,
          email: event.email,
          password: event.password);
      print("Login Info: $loginInfo");

      await sl<LoginUsecase>().call(params: loginInfo);

      emit(state.copyWith(
        isSignInLoading: false,
        signInSuccess: true,
      ));
    } catch (e) {
      print("Error during login: $e");
      emit(state.copyWith(
          isSignInLoading: false,
          signInFailure: e.toString(),
          signInSuccess: false));
    }
  }

  Future<void> _googleSignInEvent(
      GoogleSignInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isGoogleSignInLoading: true));
    try {
      await sl<GoogleSigninUsecase>().call();
      emit(state.copyWith(
        isGoogleSignInLoading: false,
        isGoogleSignInSuccess: true,
        googleSignInFailure: "",
      ));
    } catch (e) {
      emit(state.copyWith(
          isGoogleSignInLoading: false,
          googleSignInFailure: e.toString(),
          isGoogleSignInSuccess: false));
    }
  }

  void _resetToInitial(SignInReset event, Emitter<SignInState> emit) {
    emit(SignInState.initial());
  }

  void _contactEvent(ContactEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.emailOrPhone));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    // print("My Password is:${event.password}");
    emit(state.copyWith(password: event.password));
  }

  // void togglePasswordVisibility(
  //     TogglePasswordVisibility event, Emitter<SignInState> emit) {
  //   emit(state.copyWith(
  //       obscurePassword: !state.obscurePassword,
  //       iconPassword: state.obscurePassword
  //           ? CupertinoIcons.eye_slash_fill
  //           : Icons.remove_red_eye_rounded));
  // }
}
