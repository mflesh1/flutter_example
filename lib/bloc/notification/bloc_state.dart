import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {

  const NotificationState();

  @override
  List<Object> get props => [];

}

class InitialState extends NotificationState{}

class RequestPermissionComplete extends NotificationState{
  final bool granted;

  RequestPermissionComplete(this.granted);

  @override
  List<Object> get props => [granted];
}