import 'dart:convert';

import 'package:flutter/services.dart';

class ApplicationConfig {

  final String name;

  ApplicationConfig(this.name);

  static Future<ApplicationConfig> forEnvironment(String env) async {
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    final json = jsonDecode(contents);

    return ApplicationConfig(json['name']);
  }

}