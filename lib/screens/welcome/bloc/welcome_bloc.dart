import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/repositories/account_repository.dart';
import 'package:flutter_example/repositories/data_repository.dart';

import 'welcome.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final AccountRepository accountRepository;
  final DataRepository dataRepository;

  WelcomeBloc({AccountRepository accountRepository, DataRepository dataRepository})
      :  accountRepository = accountRepository ?? locator<AccountRepository>(),
        dataRepository = dataRepository ?? locator<DataRepository>();

  @override
  WelcomeState get initialState => WelcomeInitial();

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
  }

}
