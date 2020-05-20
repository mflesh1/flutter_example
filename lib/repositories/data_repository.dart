import 'dart:async';
import 'dart:convert';

import 'package:flutter_example/models/barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataRepository {

  static const String PREF_USER="prefUser";
  static const String PREF_DEVICE="prefDevice";
  static const String PREF_ON_BOARDING_RAN="prefOnboardingRan";


  static final StreamController _controller =
  StreamController<AuthenticationStatus>()
    ..add(AuthenticationStatus.unknown);

  Future<User> getUser() async {

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    User user;

    String value = preferences.get(PREF_USER);
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
    }

    return user;

  }

  Future<void> setOnBoardingRan(bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(PREF_ON_BOARDING_RAN, value);
  }

  Future<bool> getOnBoardingRan() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result = preferences.getBool(PREF_ON_BOARDING_RAN);
    if (result == null) {
      return false;
    }
    return result;
  }

  Future<void> setUser(User user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String value;
    if (user != null) {
      Map map = user.toJson();
      value = jsonEncode(map);
    }

    await preferences.setString(PREF_USER, value);

  }

  Future<void> unauthenticate() async {
    setUser(null);
    _controller.add(AuthenticationStatus.unauthorized);
  }

  Future<String> getToken() async {
    User user = await getUser();
    if (user != null) {
      return user.token;
    }
    return null;
  }

  Future<String> getRegisteredDevice() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(PREF_DEVICE);
  }

  Future<void> setRegisteredDevice(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PREF_DEVICE, value);
  }

  Stream<AuthenticationStatus> get authenticationStatus => _controller.stream;

}

enum AuthenticationStatus {
  unknown,
  unauthorized,
  authorized,
}