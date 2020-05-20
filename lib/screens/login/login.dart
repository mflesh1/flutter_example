import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/authentication/barrel.dart';
import 'package:flutter_example/bloc/authentication/bloc.dart';
import 'package:flutter_example/components/buttons/primary_button.dart';
import 'package:flutter_example/components/loading_indicator.dart';
import 'package:flutter_example/components/mixins/screen.dart';

import 'bloc/login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with ScreenHelpers {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  String email;
  String password;
  bool passwordVisible = false;

  Widget buildEmail(context) {
    return TextFormField(
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        fieldFocusChange(context, _emailFocus, _passwordFocus);
      },
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
      onSaved: (value) => email = value,
    );
  }

  Widget buildPassword(context) {
    return TextFormField(
      focusNode: _passwordFocus,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
        _submit(context);
      },
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password is required.';
        return null;
      },
      onSaved: (value) => password = value,
    );
  }

  Widget buildSubmitButton(context) {
    return new PrimaryButton(
      label: "Next",
      onPressed: () {
        _passwordFocus.unfocus();
        _emailFocus.unfocus();
        _submit(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc();
        },
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              showErrorMessage(context, state.message);
            } else if (state is LoginLoaded) {
              Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
              BlocProvider.of<AuthBloc>(context).add(new AuthorizedEvent(state.user));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildEmail(context),
                          SizedBox(height: 25.0),
                          buildPassword(context),
                          SizedBox(
                            height: 35.0,
                          ),
                          Container(
                            child: state is LoginLoading ? LoadingIndicator() : buildSubmitButton(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<LoginBloc>(context).add(new Login(email, password));
    }
  }
}
