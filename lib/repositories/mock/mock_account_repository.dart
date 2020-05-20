import 'dart:async';
import 'dart:collection';

import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/barrel.dart';

import '../../config/injection.dart';
import '../account_repository.dart';
import '../app_exception.dart';

class MockAccountRepository implements AccountRepository {
  HashMap users = new HashMap<String, User>();

  MockAccountRepository() {
    users.putIfAbsent("test@test.com", () => User(name: "Test User", token: "test@test.com"));
  }

  Future<User> login(String username, String password) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        User user = users[username];
        if (user == null) {
          throw AppException("Invalid username and/or password.");
        }
        return user;
      },
    );
  }

  @override
  Future<User> getUser() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return locator<DataRepository>().getUser();
      },
    );
  }

  @override
  Future<User> create(String name, String email, String password, bool pushEnabled, bool emailEnabled, LoginType loginType) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        if (users.containsKey(email)) {
          if (loginType == LoginType.GOOGLE) {
            return users[email];
          }
          throw new AppException("User with e-mail already exists.");
        }
        User user = User(name: name, token: email);
        users.putIfAbsent(email, () => user);
        return user;
      },
    );
  }

  @override
  Future<User> loginFederated(String token, String provider) {
    return Future.delayed(
      Duration(seconds: 1),
          () {
            User user = User(name: "Federated User", token: token);
            users.putIfAbsent("federated@$provider.com", () => user);
            return user;
      },
    );
  }
}
