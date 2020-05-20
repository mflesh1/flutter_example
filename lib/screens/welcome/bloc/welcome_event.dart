import 'package:equatable/equatable.dart';

class WelcomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WelcomeGoogleSignIn extends WelcomeEvent {

}

class WelcomeCreateGoogleAccount extends WelcomeEvent {
  final String token;

  WelcomeCreateGoogleAccount(this.token);

  @override
  List<Object> get props => [this.token];
}