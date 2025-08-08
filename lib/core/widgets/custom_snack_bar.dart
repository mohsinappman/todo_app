import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.hideCurrentSnackBar();

  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
  );

  scaffoldMessenger.showSnackBar(snackBar);
}
