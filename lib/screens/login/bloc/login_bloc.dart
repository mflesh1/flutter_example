import 'package:bloc/bloc.dart';
import 'package:flutter_example/config/injection.dart';

import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/account_repository.dart';
import 'package:flutter_example/repositories/app_exception.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AccountRepository accountRepository;

  LoginBloc({AccountRepository accountRepository}):
        accountRepository = accountRepository ?? locator<AccountRepository>();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<LoginState> _mapLoginToState(Login login) async* {
    yield LoginLoading();
    try {
      final User user = await accountRepository.login(login.username, login.password);
      yield LoginLoaded(user: user);
    } on AppException catch(e) {
      yield LoginFailure(e.code, e.getMessage());
  }
  }
}