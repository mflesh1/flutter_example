import 'package:flutter/material.dart';
import 'package:flutter_example/screens/home/home.dart';
import 'package:flutter_example/screens/login/login.dart';
import 'package:flutter_example/screens/register/register.dart';
import 'package:flutter_example/screens/student_list/screen.dart';
import 'package:flutter_example/screens/welcome/welcome.dart';

const String routeWelcome = "/";
const String routeLogin = "/login";
const String routeRegister = "/register";
const String routeHome = "/home";
const String routeRunGroupEdit = "/rungroup/edit";
const String routeStudentList = "/student/list";
const String routeMessageList = "/message/list";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWelcome:
        return MaterialPageRoute(settings: settings, builder: (_) => WelcomeScreen());
      case routeLogin:
        return MaterialPageRoute(settings: settings, builder: (_) => LoginScreen());
      case routeRegister:
        return MaterialPageRoute(settings: settings, builder: (_) => RegisterScreen());
      case routeHome:
        return MaterialPageRoute(settings: settings, builder: (_) => HomeScreen());
      case routeStudentList:
        return MaterialPageRoute(settings: settings, builder: (_) => StudentListingScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
