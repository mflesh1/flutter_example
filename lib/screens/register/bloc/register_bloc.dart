import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/account_repository.dart';
import 'package:flutter_example/repositories/app_exception.dart';
import 'package:flutter_example/repositories/data_repository.dart';

import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountRepository accountRepository;
  final DataRepository dataRepository;

  RegisterBloc({@required this.accountRepository, @required this.dataRepository});

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisteringEvent) {
      yield* _mapRegisteringToState(event);
    }
  }

  Stream<RegisterState> _mapRegisteringToState(RegisteringEvent event) async* {
    yield Registering();
    try {
      final User user = await accountRepository.create(event.name, event.email, event.password, event.pushEnabled, event.emailEnabled, LoginType.APPLICATION);
      yield Registered(user: user);
    } on AppException catch (e) {
      yield RegisterFailure(e.code, e.getMessage());
    }
  }
}
