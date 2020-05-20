import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/barrel.dart';
import 'package:flutter_example/services/navigation_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'barrel.dart';
import 'package:flutter_example/bloc/notification/bloc_event.dart';
import 'package:flutter_example/config/injection.dart';

import 'package:flutter_example/repositories/data_repository.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final DataRepository dataRepository;
  final NavigationService navigationService;

  NotificationBloc({DataRepository dataRepository, NavigationService navigationService})
      : dataRepository = dataRepository ?? locator<DataRepository>(),
        navigationService = navigationService ?? locator<NavigationService>(){


  }

  @override
  NotificationState get initialState => InitialState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is RegisterNotificationEvent) {
      yield* _mapRegisterEvent(event);
    } else if (event is RequestNotificationPermissionEvent) {
      yield* _mapRequestPermissionEvent(event);
    }
  }

  Stream<NotificationState> _mapRegisterEvent(RegisterNotificationEvent event) async* {
    try {

      PermissionStatus status = await Permission.notification.status;
      if (!status.isGranted) {
        return;
      }

      String token = event.token;

      // if no user don't register yet
      User user = await dataRepository.getUser();
      if (user == null) {
        return;
      }

      // if device is already registered and token is same as registered do not register again.
      String existingToken = await dataRepository.getRegisteredDevice();
      if (existingToken != null) {
        if (existingToken == token) {
          log("Device already registered with token [$existingToken]");
          return;
        }
      }

      log("Registered token [$token]");

      dataRepository.setRegisteredDevice(token);
    } on AppException catch (e, stacktrace) {
      log(e.getMessage(), stackTrace: stacktrace);
    } catch (error) {
      log(error);
    }
  }

  Stream<NotificationState> _mapRequestPermissionEvent(RequestNotificationPermissionEvent event) async* {
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      yield RequestPermissionComplete(true);
    }
    if (Platform.isIOS) {
      PermissionStatus result = await Permission.notification.request();
      yield RequestPermissionComplete(result.isGranted);
    } else {
      yield RequestPermissionComplete(true);
    }
  }

}