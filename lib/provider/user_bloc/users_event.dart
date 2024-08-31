import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UsersEvent {
  final int companyId;

  const FetchUsers(this.companyId);

  @override
  List<Object> get props => [companyId];
}
