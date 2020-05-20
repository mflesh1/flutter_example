import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_example/bloc/notification/barrel.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/main.dart';
import 'package:flutter_example/services/navigation_service.dart';
import 'package:flutter_example/theme/style.dart';

import 'config/localizations.dart';
import 'bloc/authentication/barrel.dart';
import 'config/router.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc()..add(LoadingEvent()),
        ),
        BlocProvider<NotificationBloc>(
          create: (BuildContext context) => NotificationBloc(),
        ),
      ],
      child: ParentApp(),
    );
  }
}

class ParentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        theme: appTheme(context),
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: Router.generateRoute,
        supportedLocales: [Locale('en', 'US')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          return supportedLocales.first;
        },
        title: AppWrapper.of(context).title,
        builder: (context, child) {
          return buildListeners(context, child);
        });
  }

  Widget buildListeners(BuildContext context, Widget child) {
    NavigationService navigationService = locator<NavigationService>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is UnauthenticatedState) {
            navigationService.navigateToAsRoot(routeWelcome);
          } else if (state is AuthenticatedState) {
            navigationService.navigateToAsRoot(routeHome);
          }
        }),
        BlocListener<NotificationBloc, NotificationState>(listener: (context, state) {})
      ],
      child: child,
    );
  }
}
