import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext{
  ColorScheme get theme => Theme.of(this).colorScheme;
  Size get mediaSize => MediaQuery.of(this).size;
}