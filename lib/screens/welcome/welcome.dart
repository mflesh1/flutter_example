import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/authentication/barrel.dart';
import 'package:flutter_example/components/components.dart';
import 'package:flutter_example/components/loading_overlay.dart';
import 'package:flutter_example/components/mixins/screen.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/config/router.dart';
import 'package:flutter_example/screens/welcome/bloc/welcome.dart';
import 'package:flutter_example/services/navigation_service.dart';
import 'package:flutter_example/theme/constants.dart';
import 'package:flutter_example/theme/theme.dart';
import 'package:sprintf/sprintf.dart';

import '../../config/localizations.dart';
import '../../main.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with ScreenHelpers {

  Widget buildRegisterButton(BuildContext context) {
    return FlatButton(
      padding: ThemeButton.padding,
      color: Colors.white,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid), borderRadius: ThemeButton.borderRadius),
      child: Text(
        AppLocalizations.of(context).translate("welcome_create_account"),
        style: TextStyle(fontSize: Theme.of(context).textTheme.button.fontSize),
      ),
      onPressed: () {
        locator<NavigationService>().navigateTo(routeRegister);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return WelcomeBloc();
        },
        child: BlocListener<WelcomeBloc, WelcomeState>(
          listener: (context, state) {
            if (state is GoogleSignInError) {
              showErrorMessage(context, state.message);
            } else if (state is GoogleSigningInComplete) {
              BlocProvider.of<WelcomeBloc>(context).add(new WelcomeCreateGoogleAccount(state.token));
            } else if (state is CreatingGoogleAccountFailed) {
              showErrorMessage(context, state.message);
            } else if (state is CreatingGoogleAccountSuccess) {
              BlocProvider.of<AuthBloc>(context).add(new AuthorizedEvent(state.user));
            }
          },
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return Container(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(Constants.kScreenPadding, 50.0, Constants.kScreenPadding, Constants.kScreenPadding),
                child: LoadingOverlay(
                  isLoading: state is CreatingGoogleAccount || state is GoogleSigningInStarted,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(sprintf(AppLocalizations.of(context).translate("welcome_title"), [AppWrapper.of(context).title]),
                          style: Theme.of(context).textTheme.headline),
                      SizedBox(height: 30.0),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            buildRegisterButton(context),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(AppLocalizations.of(context).translate("welcome_no_account"),
                                style: TextStyle(fontSize: Theme.of(context).textTheme.title.fontSize)),
                            TextLink(
                              text: AppLocalizations.of(context).translate("welcome_login"),
                              onTap: () {
                                locator<NavigationService>().navigateTo(routeLogin);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
            },
          ),
        ));
  }
}
