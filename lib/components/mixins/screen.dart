import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example/theme/theme.dart';

import '../components.dart';

class ScreenHelpers {

  /*
   * Displays an error message as a snackbar.
   */
  showErrorMessage(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
          content: Text(text, style: TextStyle(color: ThemeColors.alertErrorText, fontWeight: FontWeight.bold),),
          backgroundColor: ThemeColors.alertErrorBackground
      ),
    );
  }

  /*
   * Displays an info message as a snackbar.
   */
  showInfoMessage(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /*
   * Displays an info message as a snackbar.
   */
  showSuccessMessage(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }

  fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<void> showAlert(BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title!=null?Text(title):new Container(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(message),
            ],
          ),
          actions: <Widget>[
            DialogButton(
              label: "OK",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showConfirmDialog(BuildContext context, String title, String message, VoidCallback onConfirm) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title==null?Container():Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message),
            ],
          ),
          actions: <Widget>[
            DialogButton(
              label: "Cancel",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            DialogButton(
              label: "OK",
              onPressed: () {
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

}