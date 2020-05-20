import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;

  DialogButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: new Text(label,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.subhead.fontSize,
            color: Theme.of(context).primaryColor,
          )),
      onPressed: this.onPressed,
    );
  }
}
