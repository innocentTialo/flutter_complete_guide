import 'package:flutter/material.dart';

void showSnackBarWithAction({
  BuildContext context,
  String content,
  int durationInSeconds,
  String actionLabel,
  Function actionHandler,
}) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: durationInSeconds),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      action: SnackBarAction(
        label: actionLabel,
        textColor: Colors.amber,
        onPressed: actionHandler,
      ),
    ),
  );
}

void showSimpleSnackBar({
  BuildContext context,
  String content,
  int durationInSeconds,
}) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: durationInSeconds),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
