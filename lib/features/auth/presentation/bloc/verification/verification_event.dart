part of 'verification_bloc.dart';

sealed class VerificationEvent {
  const VerificationEvent();
}

class CodeChanged extends VerificationEvent {
  final String code;
  const CodeChanged(this.code);
}

class SubmitCode extends VerificationEvent {
  final int? code;
  final String? email;
  final String? phoneNumber;
  const SubmitCode({this.code, this.email, this.phoneNumber});
  // @override
  // List<Object> get props => [code!, email, phoneNumber!];
}

class ResendCode extends VerificationEvent {
  final String? email;
  final String? phoneNumber;
  const ResendCode({this.email, this.phoneNumber});
  // List<Object> get props => [email!, phoneNumber!];
}

class ResetCode extends VerificationEvent {}
