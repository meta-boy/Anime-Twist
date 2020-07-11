// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color getContrast(Color background) {
  Color color =
      background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  return color;
}
