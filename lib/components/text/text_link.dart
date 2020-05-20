import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {

  final String text;
  final GestureTapCallback onTap;

  const TextLink({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
            text: text,
            style:
            TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: Theme.of(context).textTheme.title.fontSize),
            recognizer: TapGestureRecognizer()
              ..onTap = onTap),
      ),
    );
  }
}
