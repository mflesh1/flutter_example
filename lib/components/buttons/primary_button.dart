
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/theme/theme.dart';

class PrimaryButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;

  PrimaryButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Theme.of(context).primaryColor,
      borderRadius: ThemeButton.borderRadius,
      child: MaterialButton(
        disabledColor: Theme.of(context).primaryColorLight,
        minWidth: MediaQuery.of(context).size.width,
        padding: ThemeButton.padding,
        onPressed:this.onPressed,
        child: Text(
          this.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }

}