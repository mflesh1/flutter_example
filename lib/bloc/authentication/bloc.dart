import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/account_repository.dart';

import 'package:flutter_example/repositories/data_repository.dart';

import 'barrel.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AccountRepository accountRepository;
  final DataRepository dataRepository;

  StreamSubscription<AuthenticationStatus> subscription;

  AuthBloc({AccountRepository accountRepository, DataRepository dataRepository}):
        accountRepository = accountRepository ?? locator<AccountRepository>(),
        dataRepository = dataRepository ?? locator<DataRepository>(){

    subscription = this.dataRepository.authenticationStatus.listen((status) {
      if (status == AuthenticationStatus.unauthorized) {
        add(UnauthorizedEvent());
      }
    });

  }

  Future<void> close() async {
    subscription.cancel();
    super.close();
  }

  @override
  AuthState get initialState => AuthenticationUnknown();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoggingOutEvent) {
      yield* _mapLoggingOutEvent(event);
    } else if (event is UnauthorizedEvent) {
      yield* _mapUnauthorizedEvent(event);
    } else if (event is LoadingEvent) {
      yield* _mapLoadingEvent(event);
    } else if (event is AuthorizedEvent) {
      yield* _mapAuthorizedEvent(event);
    }
  }

  Stream<AuthState> _mapAuthorizedEvent(AuthorizedEvent event) async* {
    await dataRepository.setUser(event.user);
    await dataRepository.setRegisteredDevice(null);
    await dataRepository.setOnBoardingRan(false);
    yield AuthenticatedState(event.user);
  }

  Stream<AuthState> _mapLoggingOutEvent(LoggingOutEvent event) async* {
    await dataRepository.setUser(null);
    await dataRepository.setRegisteredDevice(null);
    yield UnauthenticatedState();
  }

  Stream<AuthState> _mapUnauthorizedEvent(UnauthorizedEvent event) async* {
    await dataRepository.setUser(null);
    await dataRepository.setRegisteredDevice(null);
    yield UnauthenticatedState();
  }

  Stream<AuthState> _mapLoadingEvent(LoadingEvent event) async* {
    User user = await dataRepository.getUser();
    if (user != null) {
      yield AuthenticatedState(user);
    } else {
      yield UnauthenticatedState();
    }
  }
}