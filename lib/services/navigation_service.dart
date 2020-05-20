import 'package:flutter/material.dart';

/*
 * Service manages navigation within the application and allows access to navigation
 * without a context.
 */
class NavigationService {

  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  Future<dynamic> push(Route route) {
    return _navigationKey.currentState.push(route);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateRemoveUntil(String routeName, String until, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(routeName, ModalRoute.withName(until), arguments: arguments);
  }

  Future<dynamic> navigateReplace(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAsRoot(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
  }

  void pop() {
    _navigationKey.currentState.pop();
  }

  void logout() {
    _navigationKey.currentState.popUntil((Route<dynamic> route) => route.isFirst);
  }

}
