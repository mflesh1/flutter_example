import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/components/mixins/screen.dart';
import 'package:flutter_example/config/localizations.dart';
import 'package:flutter_example/bloc/authentication/barrel.dart';
import 'package:flutter_example/bloc/authentication/bloc.dart';
import 'package:flutter_example/components/buttons/primary_button.dart';
import 'package:flutter_example/components/loading_indicator.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/repositories/account_repository.dart';
import 'package:flutter_example/repositories/data_repository.dart';
import 'package:flutter_example/theme/constants.dart';

import 'bloc/register.dart';
import '../../config/localizations.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(AppLocalizations.of(context).translate("register_title")),
      ),
      body: ScreenBody(),
    );
  }
}

class ScreenBody extends StatefulWidget {
  @override
  State<ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> with ScreenHelpers {

  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool autoValidate = false;
  bool pushEnabled = true;
  bool emailEnabled = false;
  String name;
  String email;
  String password;

  Widget buildName(context) {
    return TextFormField(
      focusNode: _nameFocus,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        fieldFocusChange(context, _nameFocus, _emailFocus);
      },
      decoration: InputDecoration(
        labelText: "Full Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name is required.";
        }
        return null;
      },
      onSaved: (value) => name = value.trim(),
    );
  }

  Widget buildEmail(context) {
    return TextFormField(
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        fieldFocusChange(context, _emailFocus, _passwordFocus);
      },
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "E-mail",
      ),
      validator: (value) {
        if (!EmailValidator.validate(value)) {
          return "E-mail is invalid.";
        }
        return null;
      },
      onSaved: (value) => email = value.trim(),
    );
  }

  Widget buildPassword(context) {
    return TextFormField(
      focusNode: _passwordFocus,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
      ),
      validator: (value) {
        Pattern pattern = r'.{8,}$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value)) return 'Password must be at least 8 characters.';
        if (value == null || value.isEmpty) return 'Password is required.';
        return null;
      },
      onSaved: (value) => password = value.trim(),
    );
  }

  Widget buildPushNotification(context) {
    return Row(
      children: <Widget>[
        Switch(
            value: pushEnabled,
            onChanged: (value) {
              setState(() {
                pushEnabled = value;
              });
            }),
        Text(AppLocalizations.of(context).translate("register_push_notifications"))
      ],
    );
  }

  Widget buildEmailNotification(context) {
    return Row(
      children: <Widget>[
        Switch(
            value: emailEnabled,
            onChanged: (value) {
              setState(() {
                emailEnabled = value;
              });
            }),
        Text(AppLocalizations.of(context).translate("register_email_notifications"))
      ],
    );
  }

  Widget buildSubmitButton(context) {
    return new PrimaryButton(
      label: "Next",
      onPressed: () {
        _submit(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RegisterBloc(accountRepository: locator<AccountRepository>(), dataRepository: locator<DataRepository>());
      },
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            showErrorMessage(context, state.message);
          } else if (state is Registered) {
            Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
            BlocProvider.of<AuthBloc>(context).add(new AuthorizedEvent(state.user));
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                autovalidate: autoValidate,
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      buildName(context),
                      SizedBox(height: Constants.formElementPadding),
                      buildEmail(context),
                      SizedBox(height: Constants.formElementPadding),
                      buildPassword(context),
                      SizedBox(height: Constants.formElementPadding),
                      Text(AppLocalizations.of(context).translate("register_password_req")),
                      SizedBox(height: Constants.paragraphPadding),
                      Text(AppLocalizations.of(context).translate("register_notification_desc")),
                      SizedBox(height: Constants.paragraphPadding),
                      buildPushNotification(context),
                      buildEmailNotification(context),
                      SizedBox(height: Constants.paragraphPadding),
                      Container(
                        child: state is Registering ? LoadingIndicator() : buildSubmitButton(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _submit(BuildContext context) {
    autoValidate = true;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<RegisterBloc>(context).add(new RegisteringEvent(name, email, password, pushEnabled, emailEnabled));
    }
  }
}
