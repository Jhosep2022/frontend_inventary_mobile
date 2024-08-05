import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserRequested extends ProfileEvent {
  final String email;
  final String name;
  final String? password;
  final String firstName;
  final String secondName;
  final String phone;

  const UpdateUserRequested(this.email, this.name, this.password, this.firstName, this.secondName, this.phone);

  @override
  List<Object> get props => [email, name, password ?? '', firstName, secondName, phone];
}
