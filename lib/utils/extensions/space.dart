import 'package:flutter/material.dart';

extension Space on Widget {
  SizedBox spaceX({double extra = 0}) {
    return SizedBox(width: extra);
  }

  SizedBox spaceY({double extra = 0}) {
    return SizedBox(height: extra);
  }
}
