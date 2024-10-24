
import 'package:flutter/material.dart';

class AppNavigations {
  static Future<dynamic> nextScreen(BuildContext context, Widget screen) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<dynamic> replaceScreen(BuildContext context, Widget screen) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static Future<dynamic> pushAndRemoveAllScreen(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  static dynamic previousScreen(BuildContext context, [dynamic result]) {
    return Navigator.pop(context, result);
  }
}
