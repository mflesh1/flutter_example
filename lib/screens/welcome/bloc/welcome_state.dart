import 'package:equatable/equatable.dart';
import 'package:flutter_example/models/barrel.dart';

abstract class WelcomeState extends Equatable {

  const WelcomeState();

  @override
  List<Object> get props => [];

}

class WelcomeInitial extends WelcomeState {}

class GoogleSigningInStarted extends WelcomeState {}

class GoogleSigningInComplete extends WelcomeState {
  final String token;
  GoogleSigningInComplete(this.token);
  @override
  List<Object> get props => [this.token];
}

class GoogleSignInError extends WelcomeState {
  final String message;
  GoogleSignInError(this.message);
  @override
  List<Object> get props => [this.message];
}

class CreatingGoogleAccount extends WelcomeState {

}

class CreatingGoogleAccountSuccess extends WelcomeState {
  final User user;

  const CreatingGoogleAccountSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class CreatingGoogleAccountFailed extends WelcomeState {

  final int code;
  final String message;

  CreatingGoogleAccountFailed(this.code, this.message);

  @override
  List<Object> get props => [code, message];

}
