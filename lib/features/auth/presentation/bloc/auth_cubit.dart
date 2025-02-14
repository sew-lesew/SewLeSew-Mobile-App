import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  void login(String accessToken) {
    // Save the access token and set isAuthenticated to true
    emit(state.copyWith(isAuthenticated: true, accessToken: accessToken));
  }

  void logout() {
    // Clear the access token and set isAuthenticated to false
    emit(AuthState.initial());
  }
}

class AuthState {
  final bool isAuthenticated;
  final String? accessToken;

  AuthState({required this.isAuthenticated, this.accessToken});

  factory AuthState.initial() => AuthState(isAuthenticated: false);

  AuthState copyWith({bool? isAuthenticated, String? accessToken}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
