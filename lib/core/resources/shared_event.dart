import 'package:equatable/equatable.dart';

abstract class SharedEvent extends Equatable {
  const SharedEvent();
  @override
  List<Object> get props => [];
}

class NameChangedEvent extends SharedEvent {
  final String? firstName;
  final String? lastName;
  const NameChangedEvent({this.firstName, this.lastName});
}

class LocationEvent extends SharedEvent {
  final String? country;
  final String? state;
  final String? city;
  const LocationEvent({this.country, this.state, this.city});
}

class DateEvent extends SharedEvent {
  final String? dateOfBirth;
  final String? dateOfDisapperance;
  const DateEvent({this.dateOfBirth, this.dateOfDisapperance});
}

class ContactEvent extends SharedEvent {
  final String emailOrPhone;
  const ContactEvent(this.emailOrPhone);
}

class PasswordEvent extends SharedEvent {
  final String? password;
  final String? repassword;
  const PasswordEvent({this.password, this.repassword});
}

class PickImage extends SharedEvent {}

class PickDocument extends SharedEvent {}
