import 'package:equatable/equatable.dart';
import 'package:flutter_example/models/barrel.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingEvent extends AuthEvent {}

class LoggingOutEvent extends AuthEvent {}

class UnauthorizedEvent extends AuthEvent {}

class AuthorizedEvent extends AuthEvent {
  final User user;

  AuthorizedEvent(this.user);
}
