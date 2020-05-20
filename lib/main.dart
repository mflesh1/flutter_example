import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/config/application_config.dart';

import 'app.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
}

void main(String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  ApplicationConfig config = await ApplicationConfig.forEnvironment(env);

  configureInjection(config, env);

  runApp(AppWrapper(config.name, App()));
}

class AppWrapper extends InheritedWidget {

  final String title;
  final Widget child;

  AppWrapper(this.title, this.child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppWrapper of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppWrapper>();
  }

}
