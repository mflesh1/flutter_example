import 'dart:async';

import 'package:flutter_example/models/barrel.dart';

/*
 * Defines methods for interacting with an account.
 */
abstract class AccountRepository {

  Future<User> getUser();
  Future<User> loginFederated(String token, String provider);
  Future<User> login(String username, String password);
  Future<User> create(String name, String email, String password, bool pushEnabled, bool emailEnabled, LoginType loginType);

}