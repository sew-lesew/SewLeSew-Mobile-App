import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/shared_event.dart';
import '../../../domain/entities/user_entity.dart';
part 'sign_up_event.dart';
part "sign_up_state.dart";

class SignUpBloc extends Bloc<SharedEvent, SignUpStates> {
  @override
  SignUpBloc() : super(SignUpStates.initial()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);

    on<SignUpReset>(
      (event, emit) => emit(SignUpStates.initial()),
    );
    // on<ProfileReset>((event, emit) => emit(state.copyWith()));
    on<SignUpSubmitEvent>(_signupSubmitEvent);
  }

  Future<void> _signupSubmitEvent(
      SignUpSubmitEvent event, Emitter<SignUpStates> emit) async {
    emit(state.copyWith(isSignUpLoading: true));

    try {
      // await sl<SignUpUsecase>().call(parms: event.user);
      // await sl<AuthRepository>()!.signUp(event.user);
      // On successful sign-up, update the state
      emit(state.copyWith(
        //  user: event.user, // Use the user returned from the repository
        isSignUpLoading: false,
        signUpSuccess: true, // Set to true on success
        signUpFailure: '', // Clear any previous failure message
      ));
    } catch (e) {
      emit(state.copyWith(
        isSignUpLoading: false,
        signUpSuccess: false,
        signUpFailure: e.toString(),
      ));
    }
  }

  void _emailEvent(EmailEvent event, Emitter<SignUpStates> emit) {
    emit(
      state.copyWith(email: event.email),
    );
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignUpStates> emit) {
    print(event.password);
    print(event.repassword);

    emit(
      state.copyWith(password: event.password, repassword: event.repassword),
    );
  }
}
