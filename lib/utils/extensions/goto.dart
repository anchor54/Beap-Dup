import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

extension GoTo on BuildContext {
  //PUSH
  Future<T?> push<T>(Widget child) {
    return Navigator.of(this).push<T>(MaterialPageRoute<T>(
      builder: (context) => Directionality(
          textDirection:TextDirection.ltr,
          child: child),
    ));
  }

  //PUSH
  Future<T?> pushName<T>(String name, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(name, arguments: arguments);
  }

  //REPLACE
  pushReplacement(Widget child) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => Directionality(
          textDirection:TextDirection.ltr,
          child: child),
    ));
  }

  //REPLACE
  pushReplacementName(String name, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(name, arguments: arguments);
  }

  //PUSH AND REPLACE
  pushAndRemoveUntil(Widget child) {
    Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Directionality(
              textDirection:TextDirection.ltr,
                child: child)),
        (Route<dynamic> route) => false);
  }

  //PUSH AND REPLACE
  pushNameAndRemoveUntil(String name, {Object? arguments}) {
    Navigator.of(this)
        .pushNamedAndRemoveUntil(name, (route) => false, arguments: arguments);
  }

  //POP
  pop({Object? value}) {
    Navigator.of(
      this,
      rootNavigator: true,
    ).pop(value);
  }
}
