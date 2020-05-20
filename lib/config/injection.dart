import 'package:get_it/get_it.dart';
import 'package:flutter_example/config/application_config.dart';
import 'package:flutter_example/services/navigation_service.dart';

import '../repositories/mock/barrel.dart';
import '../repositories/barrel.dart';

final locator = GetIt.instance;

void configureInjection(ApplicationConfig config, String env) {
  locator.registerLazySingleton(() => DataRepository());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerFactory<MessageRepository>(() => MockMessageRepository());
  locator.registerFactory<StudentRepository>(() => MockStudentRepository());
  locator.registerFactory<AccountRepository>(() => MockAccountRepository());
}

abstract class Env {
  static const mock = 'mock';
  static const test = 'test';
  static const prod = 'prod';
}
