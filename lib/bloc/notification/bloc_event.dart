import 'package:equatable/equatable.dart';
import 'package:flutter_example/bloc/notification/barrel.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterNotificationEvent extends NotificationEvent {
  final String token;

  RegisterNotificationEvent({this.token});

  @override
  List<Object> get props => [token];
}

class RequestNotificationPermissionEvent extends NotificationEvent {}