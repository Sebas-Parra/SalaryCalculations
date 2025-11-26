import 'package:flutter/material.dart';
import './color_schema.dart';

class RadioButtonTheme {
  static final RadioThemeData primaryRadioButton = RadioThemeData(
    fillColor: MaterialStateProperty.all(ColorSchema.primaryColor),
    overlayColor: MaterialStateProperty.all(ColorSchema.primaryColor.withOpacity(0.1)),
    splashRadius: 20,
  );
}